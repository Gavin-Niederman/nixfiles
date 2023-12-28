import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const Bar = ({monitor, name, anchor, child}) => Widget.Window({
    monitor,
    name: `${name}-${monitor}`,
    anchor,
    exclusivity: "exclusive",
    child,
})