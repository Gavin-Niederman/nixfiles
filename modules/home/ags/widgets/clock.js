const { exec } = ags.Utils;
const { Label } = ags.Widget;

export const Clock = ({...rest}) => Label({
    ...rest,
    className: ['clock'],
    connections: [[1000, label => label.label = exec('date +%H:%M:%S').trim()]],
});