import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';


export const Clock = ({ ...rest }) => Widget.Label({
    ...rest,
    className: 'clock',
}).poll(1000, label => execAsync(['date', '+%H:%M:%S']).then((time) => label.label = time.trim()));