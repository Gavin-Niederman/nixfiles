const { ProgressBar } = ags.Widget;

export const Battery = ({}) => ProgressBar({
    className: ['battery'],
    vertical: false,
    min: 0,
    max: 100,
    progress: ags.Service.Battery.percent,
    connections: [
        [
            ags.Service.Battery,
            progess => {
                progess.progress = ags.Service.Battery.percent;
            },
            'changed'
        ]
    ] 
});