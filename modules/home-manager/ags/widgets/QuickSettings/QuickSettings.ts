import { Audio, Dummy } from "widgets";
import Brightness from "./Brightness";
import { Brightness as BrightnessService } from "services";
import PowerProfile from "./PowerProfile";

const QuickSettings = () => Widget.Window({
    visible: false,
    keymode: "on-demand",
    exclusivity: "normal",
    name: "quick-settings",
    layer: "top",
    anchor: ["bottom", "left"],
    child: Widget.Box({
        className: "quick-settings-container",
        vertical: true,
        hpack: "start",
        children: [
            // Brightness slider
            BrightnessService.available ? Brightness() : Dummy(),
            Audio(false, false, true),
            PowerProfile(),
        ],
    }),
}).keybind("Escape", () => App.closeWindow("quick-settings"));

export default QuickSettings;