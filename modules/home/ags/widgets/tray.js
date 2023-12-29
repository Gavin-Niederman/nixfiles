import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';

export const Tray = ({ }) => Widget.Box({
    className: 'tray',
    hexpand: true,
    spacing: 10,
    children: SystemTray.bind('items').transform(items => items.map(item => Widget.Button({
        cursor: "pointer",
        child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        binds: [['tooltip-markup', item, 'tooltip-text']],
    })))
})