const { exec } = ags.Utils;

const bar = (id) => ({
    monitor: id,
    name: `bar-${id}`,
    anchor: ['top', 'left', 'right'],
    exclusive: true,
    child: {
        type: 'box',
        children: [
            clock
        ],
    },
})

const clock = {
    type: 'label',
    connections: [[1000, label => label.label = exec('date +%H:%M:%S').trim()]],
};

var config = {
    baseIconSize: 18,
    closeWindowDelay: {
        'window-name': 500, // milliseconds
    },
    exitOnError: false,
    notificationPopupTimeout: 5000, // milliseconds
    stackTraceOnError: false,
    style: '/home/gavin/.config/ags/style.css',
    windows: [ 
        ...ags.Service.Hyprland.HyprctlGet('monitors').map(({id}) => bar(id)),
     ]
};
