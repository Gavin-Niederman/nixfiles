export const Clock = ({ ...rest }) => Widget.Label({
    ...rest,
    className: 'clock',
}).poll(1000, label => Utils.execAsync(['date', '+%H:%M:%S']).then((time) => label.label = time.trim()));