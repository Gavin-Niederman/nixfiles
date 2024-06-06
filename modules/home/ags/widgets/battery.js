const Battery = await Service.import('battery');

export const BatteryBar = ({ }) => Widget.Overlay({
    vpack: 'center',
    child: Widget.ProgressBar({
        className: 'battery',
        vertical: false,
    }),
    pass_through: true,
    overlays: [
        Widget.Stack({
            transition: 'crossfade',
            children: {
                'charging':
                    Widget.Icon({
                        icon: `${App.configDir}/icons/lightning.svg`,
                        size: 15,
                        css: "color: #2e3440"
                    }),
                'draining':
                    Widget.Icon({
                        icon: `${App.configDir}/icons/battery.svg`,
                        size: 15,
                        css: "color: #2e3440"
                    }),
                'low':
                    Widget.Icon({
                        icon: `${App.configDir}/icons/battery-alert.svg`,
                        size: 15,
                        css: "color: #2e3440"
                    })
            }
        })
            .hook(Battery, stack => {
                if (Battery.charging) {
                    stack.shown = 'charging';
                } else {
                    if (Battery.percent < 15) {
                        stack.shown = 'low';
                    } else {
                        stack.shown = 'draining';
                    }
                }
            })
    ]
})
    .hook(Battery, overlay => {
        overlay.child.value = Battery.percent / 100;
        overlay.child.visible = Battery.available
    });