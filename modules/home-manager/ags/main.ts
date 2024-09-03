import Gdk from "gi://Gdk";
import TopBar from "widgets/TopBar";

const numMonitors = Gdk.Display.get_default()?.get_n_monitors() || 1;
const monitors = Array.from({ length: numMonitors }, (_, i) => i);

App.config({
    windows: monitors.map((monitor) => TopBar(monitor)),
});