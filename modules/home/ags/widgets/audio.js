const Audio = await Service.import('audio');

export const AudioBar = ({ }) => Widget.Slider({
    className: 'audio',
    vertical: false,
    drawValue: false,
    min: 0,
    max: 1,
    value: 0,
    on_change: ({ value }) => { Audio.speaker.volume = value },
})
    .hook(
        Audio,
        slider => {
            slider.value = Audio.speaker.volume;
        },
        'speaker-changed'
    );