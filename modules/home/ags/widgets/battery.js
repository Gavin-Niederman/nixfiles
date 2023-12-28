import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';

export const BatteryBar = ({}) => Widget.ProgressBar({
    className: 'battery',
    vertical: false,
})
.hook(Battery, bar => {
    bar.value = Battery.percent
    bar.visible = Battery.available
});