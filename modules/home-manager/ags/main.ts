import Gdk from "gi://Gdk";
import Niri from "services/Niri";
import ClockUnderlay from "widgets/ClockUnderlay";
import ScreenBevels from "widgets/ScreenBevels";
import SideBar from "widgets/SideBar";

App.addIcons(App.configDir + '/assets');

const numMonitors = Gdk.Display.get_default()?.get_n_monitors() || 1;
const monitors = Array.from({ length: numMonitors }, (_, i) => i);

function forEachMonitor<T>(generator: (monitor: number) => T): T[] {
    return monitors.map(generator);
}

App.config({
    // generated in config.js
    style: "/tmp/ags/style.css",
    windows: [
        ...forEachMonitor((monitor) => SideBar(monitor, Object.keys(Niri.outputs)[monitor])),
        ...forEachMonitor((monitor) => ScreenBevels(monitor)),
        ...forEachMonitor((monitor) => ClockUnderlay(monitor)),
    ],
});