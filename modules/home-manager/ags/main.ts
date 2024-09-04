import Gdk from "gi://Gdk";
import Niri from "services/Niri";
import TopBar from "widgets/TopBar";

App.addIcons(App.configDir + '/assets');

const numMonitors = Gdk.Display.get_default()?.get_n_monitors() || 1;
const monitors = Array.from({ length: numMonitors }, (_, i) => i);

App.config({
    // generated in config.js
    style: "/tmp/ags/style.css",
    windows: monitors.map((monitor) => TopBar(monitor, Object.keys(Niri.outputs)[monitor])),
});