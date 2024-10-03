import Gtk from "gi://Gtk";
import { SymbolicIcon, Dummy } from "widgets";
const AudioService = await Service.import('audio');

const Audio = (vertical: boolean, drawValue: boolean = true, expand: boolean = false) => Widget.Box({
    className: "audio",
    vertical,
    children: [
        Widget.Stack({
            children: {
                "on": SymbolicIcon({
                    icon: "speaker-on-symbolic",
                    onClicked: () => AudioService.speaker.is_muted = !AudioService.speaker.is_muted,
                    size: 24
                }),
                "off": SymbolicIcon({
                    icon: "speaker-off-symbolic",
                    onClicked: () => AudioService.speaker.is_muted = !AudioService.speaker.is_muted,
                    size: 24
                })
            },
            shown: AudioService.speaker.bind("is_muted").as(m => m ? "off" : "on"),
        }),
        drawValue ? Widget.Label({
            className: "percent-display",
            label: AudioService.speaker.bind("volume").as(p => `${(p * 100).toFixed(0)}%`),
        }) : Dummy(),
        Widget.Slider({
            classNames: AudioService.speaker.bind("is_muted")
                .as(muted =>
                    ["volume-slider"]
                        .concat(vertical ? ["vertical"] : ["horizontal"])
                        .concat(muted ? ["muted"] : [])
                ),
            orientation: vertical ? Gtk.Orientation.VERTICAL : Gtk.Orientation.HORIZONTAL,
            inverted: vertical,
            drawValue: false,
            value: AudioService.speaker.bind("volume").as(v => v * 100),
            min: 0,
            max: 100,
            expand,
            onChange: (args: { value: number }) => AudioService.speaker.volume = args.value / 100,
        })
    ]
});

export default Audio;