const Hyprland = await Service.import('hyprland');

const classNames = (full, current) => {
    let classes = ['workspace'];
    if (full) classes.push('full');
    if (current) classes.push('current');
    return classes;
}

const Workspace = ({ id, full, current }) => Widget.Button({
    cursor: "pointer",
    classNames: classNames(full, current),
    child: Widget.Label({
        className: 'workspace-label',
        label: `${id}`,
    }),
})
    .on('clicked', _ => {
        Hyprland.messageAsync(`/dispatch split-workspace ${id}`)
    })

export const Workspaces = ({ monitor }) => Widget.Box({
    className: 'workspaces',
})
    .hook(
        Hyprland,
        box => {
            const workspaces = Hyprland.workspaces;
            let children = Array.from({ length: 10 }, (_, i) => {
                const workspaceID = i + (monitor * 10) + 1;
                const current = Hyprland.monitors[monitor].activeWorkspace.id === workspaceID;
                try {
                    const workspace = workspaces.filter(w => w.id === workspaceID)[0];
                    return Workspace({ id: i + 1, full: workspace.windows > 0, current });
                } catch (err) {
                    return Workspace({ id: i + 1, full: false, current });
                }
            })

            box.children = children;
        },
        'changed'
    )
