const SystemTray = await Service.import('systemtray');

export const Tray = ({ }) => Widget.Box({
    className: 'tray',
    hexpand: true,
    spacing: 10,
    children: SystemTray.bind('items').transform(items => items.map(item => Widget.Button({
        cursor: "pointer",
        child: Widget.Icon({ icon: item.bind('icon') }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
    })))
})