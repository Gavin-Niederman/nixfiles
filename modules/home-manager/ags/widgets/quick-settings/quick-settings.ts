import { Audio, Dummy, PaddedWindow } from "widgets";
import Brightness from "./brightness";
import { Brightness as BrightnessService } from "services";
import PowerProfile from "./power-profile";
import Flavor from "./flavor";

const QuickSettings = () => PaddedWindow({
    location: "bottom-left",
    paddingClass: "quick-settings-padding",
    visible: false,
    keymode: "on-demand",
    exclusivity: "normal",
    name: "quick-settings",
    layer: "top",
    anchor: ["bottom", "left", "top", "right"],
    expand: true,
    child:
        Widget.Box({
            className: "quick-settings-container",
            vertical: true,
            hpack: "start",
            vpack: "end",
            expand: false,
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