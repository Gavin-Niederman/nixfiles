import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

export const BatteryBar = ({}) => Widget.Overlay({
    vpack: 'center',
    child: Widget.ProgressBar({
        className: 'battery',
        vertical: false,
    }),
    pass_through: true,
    overlays: [
        Widget.Icon({
            icon: `${App.configDir}/icons/lightning.svg`,
            size: 15,
            css: "color: #2e3440"
        })
    ]
})
.hook(Battery, overlay => {
    overlay.child.value = Battery.percent / 100;
    overlay.child.visible = Battery.available
});