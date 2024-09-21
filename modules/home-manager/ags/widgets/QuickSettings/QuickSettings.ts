import Brightness from "./Brightness";

const QuickSettings = () => Widget.Window({
    visible: true,
    keymode: "on-demand",
    exclusivity: "normal",
    name: "quick-settings",
    layer: "top",
    anchor: ["bottom", "left"],
    child: Widget.Box({
        className: "quick-settings-container",
        vertical: true,
        children: [
            // Brightness slider
            Brightness(),
        ],
    }),
}).keybind("Escape", () => App.closeWindow("quick-settings"));

export default QuickSettings;