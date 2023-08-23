const { Window } = ags.Widget;

export const Bar = ({monitor, name, anchor, child}) => Window({
    monitor,
    name: `${name}-${monitor}`,
    anchor,
    exclusive: true,
    child,
})