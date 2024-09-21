import { Audio, Dummy } from "widgets";
import Brightness from "./Brightness";
import { Brightness as BrightnessService } from "services";

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
            BrightnessService.available ? Brightness() : Dummy(),
            Audio(false, false),
        ],
    }),
}).keybind("Escape", () => App.closeWindow("quick-settings"));

export default QuickSettings;