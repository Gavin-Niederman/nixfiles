export const Bar = ({monitor, name, anchor, child}) => Widget.Window({
    monitor,
    name: `${name}-${monitor}`,
    anchor,
    exclusivity: "exclusive",
    child,
})