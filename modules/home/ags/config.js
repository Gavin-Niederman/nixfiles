import { TopBar } from "./layouts/topbar.js";
import { NotificationPopups } from "./layouts/notificationPopups.js";
import { compileScss } from "./style/style.js";
const hyprland = await Service.import("hyprland");

const css_path = compileScss();
Utils.monitorFile(
    css_path,
    () => {
        App.resetCss();
        App.applyCss(css_path);
    },
);

const monitors = await hyprland.messageAsync('j/monitors')
    .then((json_data) => {
        console.log(json_data)
        const data = JSON.parse(json_data);
        console.log(data)
        return data.map(mon => mon.id)
    })
    .then(ids => {
        console.log(ids)
        return ids
    })
    .catch(err => console.error(err));

App.config({
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
        NotificationPopups(2),
    ]
});
