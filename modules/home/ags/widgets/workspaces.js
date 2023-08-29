const { Hyprland } = ags.Service;
const { Box, Button, Label } = ags.Widget;
const { execAsync } = ags.Utils;

const Workspace = ({ id, full }) => Button({
    className: full ? ['workspace', 'full'] : ['workspace'],
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
                    try {
                        const workspace = workspaces.get(i + (monitor * 10) + 1);
                        return Workspace({ id: i + 1, full: workspace.windows > 0 });
                    } catch (err) {
                        return Workspace({ id: i + 1, full: false });
                    }
                })

                box.children = children;
            },
            'changed'
        ]
    ],
})
