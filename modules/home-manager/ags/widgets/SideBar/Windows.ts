import { Niri } from "services";
const Apps = await Service.import("applications");

const Dummy = () => Widget.Box({ visible: false });

const Window = (app_id: string | undefined, id: number, focused: boolean, active: boolean) => {
    if (!app_id) return Dummy();
    const app = Apps.list.find(a => a.match(app_id));

    let icon = app?.icon_name || app_id; focused
    if (Utils.lookUpIcon(icon) === null) {
        icon = "application-x-executable";
    }

    return Widget.Button({
        classNames: ["window"]
            .concat(focused ? ["focused"] : [])
            .concat(active ? ["active"] : []),
        child: Widget.Icon({ icon: icon, size: 16 }),
        onClicked: () => {
            Niri.messageAsync(["action", "focus-window", "--id", id.toString()]);
        },
    })
};

const WorkspaceWindows = (workspace: number) => Widget.Box({
    className: "workspace-windows",
    vertical: true,
    hpack: "center",
    children: Niri.bind("windows").as(windows => windows
        .filter(w => w.workspace_id === workspace)
        .filter(w => w.app_id !== "com.github.Aylur.ags")
        .map(window => Window(window.app_id, window.id, window.is_focused, Niri.active_windows.some(w => w.id === window.id))))
});

const Windows = () => Widget.Box({
    className: "windows",
    vertical: true,
    children: Niri.bind("workspaces")
        .as(workspaces => workspaces.sort((a, b) => a.idx - b.idx)
            .map(w => WorkspaceWindows(w.id)).flat()
        )
})

export default Windows;