const { Slider } = ags.Widget;
const { execAsync } = ags.Utils;

export const Audio = ({}) => Slider({
    className: ['audio'],
    vertical: false,
    drawValue: false,
    min: 0,
    max: 1,
    value: 0,
    onChange: ({ value }) => ags.Service.Audio.speaker.volume = value,
    connections: [
        [
            ags.Service.Audio,
            slider => {
                slider.value = ags.Service.Audio.speaker.volume;
            },
            'speaker-changed'
        ]
    ],
});