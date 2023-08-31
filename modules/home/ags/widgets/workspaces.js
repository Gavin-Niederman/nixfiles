const { Hyprland } = ags.Service;
const { Box, Button, Label } = ags.Widget;
const { execAsync } = ags.Utils;

const classNames = (full, current) => {
    let classes = ['workspace'];
    if (full) classes.push('full');
    if (current) classes.push('current');
    return classes;
}

const Workspace = ({ id, full, current }) => Button({
    className: classNames(full, current),
    child: Label({
        className: ['workspace-label'],
        label: `${id}`,
    }),
    connections: [
        [
            'clicked', () => execAsync(`hyprctl dispatch split-workspace ${id}`)
        ]
    ],
})

export const Workspaces = ({ monitor }) => Box({
    className: ['workspaces'],
    connections: [
        [
            Hyprland,
            box => {
                const workspaces = Hyprland.workspaces;
                let children = Array.from({ length: 10 }, (_, i) => {
                    const workspaceID = i + (monitor * 10) + 1;
                    const current = Hyprland.monitors.get(monitor).activeWorkspace.id === workspaceID;
                    try {
                        const workspace = workspaces.get(workspaceID);
                        return Workspace({ id: i + 1, full: workspace.windows > 0, current });
                    } catch (err) {
                        return Workspace({ id: i + 1, full: false, current });
                    }
                })

                box.children = children;
            },
            'changed'
        ]
    ],
})
