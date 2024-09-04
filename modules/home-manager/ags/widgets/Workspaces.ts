import Niri from "services/Niri";

const Workspaces = (output: string) => Widget.Box({
    className: "workspaces"
})
    .hook(Niri, box => {
        const children = Niri.workspaces.filter(w => w.output === output).map(workspace => {
            return Widget.Button({
                className: "workspace",
                label: workspace.name ?? workspace.idx.toString(),
                onClicked: () => {
                    Niri.message(["action", "focus-workspace", `${workspace.idx}`]);
                    log(`Switched to workspace ${workspace.idx}`);
                },
            });
        });
        box.children = children;
    }, 'changed');

export default Workspaces;