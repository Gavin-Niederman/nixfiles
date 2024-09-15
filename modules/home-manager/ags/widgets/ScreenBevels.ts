const ScreenBevels = (monitor: number) => Widget.Window({
    monitor,
    anchor: ["top", "bottom", "right", "left"],
    className: "screen-bevels",
    clickThrough: true,
    expand: true,
    child: Widget.Box({
        expand: true,
        className: "shadow",
        child: Widget.Box({
            expand: true,
            className: "bevels",
        })
    })
})

export default ScreenBevels;