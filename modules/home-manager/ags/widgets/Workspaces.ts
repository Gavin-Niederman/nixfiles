import Niri from "services/Niri";

const Workspace = (idx: number, active: boolean) => Widget.Button({
    classNames: active ? ["workspace", "active"] : ["workspace"],
    label: idx.toString(),
    onClicked: () => {
        Niri.messageAsync(["action", "focus-workspace", idx.toString()]);
    },
});

const Workspaces = (output: string) => Widget.Box({
    className: "workspaces",
    children: Niri.bind("workspaces").as(workspaces =>
        workspaces.filter(w => w.output === output)
            .sort((a, b) => a.id - b.id)
            .map(workspace => Workspace(workspace.idx, workspace.is_active))
    )
});

export default Workspaces;