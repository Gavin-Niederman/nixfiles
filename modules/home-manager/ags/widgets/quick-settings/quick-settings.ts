import { Audio, Dummy } from "widgets";
import Brightness from "./brightness";
import { Brightness as BrightnessService } from "services";
import PowerProfile from "./power-profile";
import Flavor from "./flavor";

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
            Flavor(),
        ],
    }),
}).keybind("Escape", () => App.closeWindow("quick-settings"));

export default QuickSettings;