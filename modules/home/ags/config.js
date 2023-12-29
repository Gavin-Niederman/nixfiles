import { TopBar } from "./layouts/topbar.js";
import { compileScss } from "./style/style.js";
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import { monitorFile } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

const css_path = compileScss();
monitorFile(
    css_path,
    () => {
        App.resetCss();
        App.applyCss(css_path);
    },
);

const monitors = await Hyprland.sendMessage('j/monitors')
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
