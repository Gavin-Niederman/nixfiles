import Gdk from "gi://Gdk";
import { Niri, Style } from "services";
import {
    ClockUnderlay, ScreenBevels, SideBar, QuickSettings,
    LogoutMenu
} from "widgets";

App.addIcons(App.configDir + '/assets');

const display = Gdk.Display.get_default();
display?.get_screen
const numMonitors = display?.get_n_monitors() || 1;
const monitors = Array.from(
    { length: numMonitors },
    (_, i) => ({
        monitor: i,
        output: Object.entries(Niri.outputs)
            .find(
                (o) => o[1].model === display?.get_monitor(i)?.get_model()
            )?.[0] || undefined
    })
);

function forEachMonitor<T>(generator: (monitor: number, output: string | undefined) => T): T[] {
    return monitors.map(({ monitor, output }) => generator(monitor, output));
}

Style.connect("style-rebuilt", (service) => {
    App.applyCss(service.output_path, true);
});

await Style.buildStyle();

App.config({
    // generated in config.js
    style: "/tmp/ags/style.css",
    windows: [
        ...forEachMonitor((monitor, output) => SideBar(monitor, output!)),
        ...forEachMonitor((monitor) => ScreenBevels(monitor)),
        ...forEachMonitor((monitor) => ClockUnderlay(monitor)),
        QuickSettings(),
        LogoutMenu()
    ],
});