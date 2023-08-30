const { ProgressBar } = ags.Widget;

export const Battery = ({}) => ProgressBar({
    className: ['battery'],
    vertical: false,
    value: Math.max(0, ags.Service.Battery.percent / 100),
    connections: [
        [
            ags.Service.Battery,
            progess => {
                progess.value = Math.max(0, ags.Service.Battery.percent / 100);
            },
            'changed'
        ]
    ] 
});