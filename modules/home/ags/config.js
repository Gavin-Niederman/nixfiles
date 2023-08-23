import { TopBar } from "./layouts/topbar.js";

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
    style: '/home/gavin/.config/ags/style.css',
    windows: [
        ...monitors.map(id => TopBar(id)),
    ]
};
