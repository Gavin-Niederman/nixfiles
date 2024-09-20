const SystemPanel = () => Widget.Window({
    visible: true,
    keymode: "on-demand",
    exclusivity: "normal",
    name: "system-panel",
    layer: "top",
    anchor: ["bottom", "left"],
    child: Widget.Box({
        className: "system-panel-container",
        children: [
            Widget.Label({ label: "Hiiiii :3" })
        ],
    }),
}).keybind("Escape", () => App.closeWindow("system-panel"));

export default SystemPanel;