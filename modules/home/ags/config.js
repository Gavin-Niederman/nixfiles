import { TopBar } from "./layouts/topbar.js";
import { compileScss } from "./style/style.js";

const monitors = ags.Service.Hyprland.HyprctlGet('monitors')
    .map(mon => mon.id);

export default {
    baseIconSize: 18,
    closeWindowDelay: {
        'bar': 500, // milliseconds
    },
    exitOnError: false,
    notificationPopupTimeout: 5000, // milliseconds
    stackTraceOnError: false,
    style: compileScss(),
    windows: [
        ...monitors.map(id => TopBar(id)),
    ]
};
