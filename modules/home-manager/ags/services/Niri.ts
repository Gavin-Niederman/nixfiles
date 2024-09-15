import GLib from 'gi://GLib';
import Gio from 'types/@girs/gio-2.0/gio-2.0';

export interface Workspace {
    id: number,
    idx: number,
    name: string | undefined,
    output: string | undefined,
    is_active: boolean,
    is_focused: boolean,
    active_window_id: number | undefined,
}

export interface Window {
    id: number,
    title: string | undefined,
    app_id: string | undefined,
    workspace_id: number | undefined,
    is_focused: boolean,
}

export type Event = {
    WorkspacesChanged: {
        workspaces: Workspace[],
    }
} | {
    WorkspaceActivated: {
        id: number,
        focused: boolean,
    }
} | {
    WorkspaceActiveWindowChanged: {
        workspace_id: number,
        active_window_id: number | undefined,
    }
} | {
    WindowsChanged: {
        windows: Window[],
    }
} | {
    WindowOpenedOrChanged: {
        window: Window,
    }
} | {
    WindowClosed: {
        id: number,
    }
} | {
    WindowFocusChanged: {
        id: number | undefined,
    }
}

export interface Output {
    name: string,
    make: string,
    model: string,
    serial: string | undefined,
    //TODO: Modes and size
    current_mode: number | undefined,
    vrr_supported: boolean,
    vrr_enabled: boolean,
    //TODO: Logical
}

export class NiriService extends Service {
    private streamListener: Gio.Subprocess;

    static {
        Service.register(this, {
            "workspace-activated": ["int"],
            "workspace-active-window-changed": ["int", "int"],

            "window-added-or-changed": ["int"],
            "window-closed": ["int"],
            "window-focus-changed": ["int"],
        },
            {
                "outputs": ["jsobject", "r"],
                "windows": ["jsobject", "r"],
                "workspaces": ["jsobject", "r"],
                "active-windows": ["jsobject", "r"],
                "active-workspaces": ["jsobject", "r"],
                "focused-window": ["jsobject", "r"],
            }
        );
    }

    private _windows: Window[] = [];
    private _workspaces: Workspace[] = [];
    private _outputs: { [key: string]: Output } = {};

    private _activeWindows: { [key: number]: number } = [];
    private _activeWorkspaces: number[] = [];
    private _focusedWindow: number | undefined = undefined;

    get windows() {
        return this._windows;
    }
    get workspaces() {
        return this._workspaces;
    }
    get outputs() {
        return this._outputs;
    }
    get active_windows() {
        return Object.values(this._activeWindows).map(id => this.getWindow(id)).filter(w => w !== undefined) as Window[];
    }
    get active_workspaces() {
        return this._activeWorkspaces.map(id => this.getWorkspace(id)).filter(w => w !== undefined) as Workspace[];
    }
    get focused_window() {
        return this._focusedWindow !== undefined ? this.getWindow(this._focusedWindow) : undefined;
    }

    readonly getWorkspace = (id: number) => this._workspaces.find(w => w.id === id);
    readonly getWindow = (id: number) => this._windows.find(w => w.id === id);

    // Incredible stuff here
    readonly message = (args: string[]) => {
        return Utils.exec(["niri", "msg", "-j", ...args]);
    }
    readonly messageAsync = async (args: string[]) => {
        return Utils.execAsync(["niri", "msg", "-j", ...args]);
    }

    private readonly handleEvent = (event: Event) => {
        if ("WorkspacesChanged" in event) {
            const { workspaces } = event.WorkspacesChanged;
            this._workspaces = workspaces;
            this.notify("workspaces");
            this.emit("changed");
        }
        else if ("WorkspaceActivated" in event) {
            const { id, focused } = event.WorkspaceActivated;
            const workspace = this.getWorkspace(id);
            if (workspace === undefined) {
                console.warn(`Workspace with id ${id} not found`);
                return;
            }

            this.workspaces.forEach(w => {
                if (w.output === workspace.output) {
                    w.is_active = false;
                    w.is_focused = false;
                }
            })

            workspace.is_active = true;
            workspace.is_focused = focused;
            this._activeWorkspaces.filter(w => this.getWorkspace(w)?.output !== workspace.output ?? true);
            this._activeWorkspaces.push(id);
            this.notify("active-workspaces");
            this.notify("workspaces");
            this.emit("workspace-activated", id);
        }
        else if ("WorkspaceActiveWindowChanged" in event) {
            const { workspace_id, active_window_id } = event.WorkspaceActiveWindowChanged;
            const workspace = this.getWorkspace(workspace_id);
            if (workspace === undefined) {
                console.warn(`Workspace with id ${workspace_id} not found`);
                return;
            }
            workspace.active_window_id = active_window_id;
            if (active_window_id !== undefined) {
                this._activeWindows[workspace_id] = active_window_id;
            }
            this.notify("active-windows");
            this.notify("workspaces");
            this.emit("workspace-active-window-changed", workspace_id, active_window_id);
        }
        else if ("WindowsChanged" in event) {
            const { windows } = event.WindowsChanged;
            this._windows = windows;
            this.notify("windows");
        }
        else if ("WindowOpenedOrChanged" in event) {
            const { window } = event.WindowOpenedOrChanged;
            const existingWindow = this.getWindow(window.id);
            if (existingWindow !== undefined) {
                Object.assign(existingWindow, window);
            } else {
                this._windows.push(window);
            }
            this.notify("windows");
            this.emit("window-added-or-changed", window.id);
        }
        else if ("WindowClosed" in event) {
            const { id } = event.WindowClosed;
            this._windows = this.windows.filter(w => w.id !== id);
            this.notify("windows");
            this.emit("window-closed", id);
        }
        else if ("WindowFocusChanged" in event) {
            const { id } = event.WindowFocusChanged;
            if (id === undefined) {
                return;
            }

            const focusedWindow = this.focused_window;
            if (focusedWindow !== undefined) {
                focusedWindow.is_focused = false;
            }

            this._focusedWindow = id;

            const window = this.getWindow(id);

            if (window === undefined) {
                console.warn(`Window with id ${id} not found`);
                return;
            }
            window.is_focused = true;

            this.notify("focused-window");
            this.notify("windows");
            this.emit("window-focus-changed", id);
            this.emit("changed");
        }
        else {
            console.warn(`Unknown niri event variant: ${Object.keys(event)[0]}`);
        }
    }

    constructor() {
        super();

        if (GLib.getenv("NIRI_SOCKET") === null) {
            logError("Niri IPC is not running. The Niri service will not work properly.");
        }

        this._outputs = JSON.parse(this.message(["outputs"]));
        this.notify("outputs");

        this._windows = JSON.parse(this.message(["windows"]));
        this.notify("windows");
        this._workspaces = JSON.parse(this.message(["workspaces"]));
        this.notify("workspaces");

        this._activeWindows = this.workspaces.reduce((acc, w) => {
            if (w.active_window_id !== undefined) {
                acc[w.id] = w.active_window_id;
            }
            return acc;
        }, {});
        this.notify("active-windows");

        this._activeWorkspaces = this.workspaces.filter(w => w.is_active).map(w => w.id);
        this.notify("active-workspaces");

        this._focusedWindow = this.windows.find(w => w.is_focused)?.id;
        this.notify("focused-window");

        this.emit("changed");

        this.streamListener = Utils.subprocess(
            ["niri", "msg", "-j", "event-stream"],
            (output) => {
                const event: Event = JSON.parse(output);
                this.handleEvent(event);
            },
            error => logError(error),
        );
    }

    destructor() {
        this.streamListener.force_exit();
    }
}

const niri = new NiriService();
export default niri;