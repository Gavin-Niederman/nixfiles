import Gtk from "gi://Gtk";

const AudioService = await Service.import('audio');

const Audio = (vertical: boolean) => Widget.Box({
    className: "audio",
    vertical,
    children: [
        Widget.Stack({
            children: {
                "on": Widget.Icon({
                    icon: "speaker-on-symbolic",
                    css: "color: #cad3f5",
                    size: 24
                }),
                "off": Widget.Icon({
                    icon: "speaker-off-symbolic",
                    css: "color: #cad3f5",
                    size: 24
                })
            },
            shown: AudioService.speaker.bind("is_muted").as(m => m ? "off" : "on"),
        }),
        Widget.Label({
            className: "percent-display",
            label: AudioService.speaker.bind("volume").as(p => `${(p * 100).toFixed(0)}%`),
        }),
        Widget.Slider({
            classNames: AudioService.speaker.bind("is_muted")
                .as(muted =>
                    ["volume-slider"]
                        .concat(vertical ? ["vertical"] : ["horizontal"])
                        .concat(muted ? ["muted"] : [])
                ),
            orientation: Gtk.Orientation.VERTICAL,
            inverted: true,
            drawValue: false,
            value: AudioService.speaker.bind("volume").as(v => v * 100),
            min: 0,
            max: 100,
            onChange: (args: { value: number }) => AudioService.speaker.volume = args.value / 100,
        })
    ]
});

export default Audio;