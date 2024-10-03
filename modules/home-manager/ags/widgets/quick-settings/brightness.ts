import { Brightness as BrightnessService } from "services";
import { SymbolicIcon } from "widgets";

const Brightness = () => Widget.Box({
    vertical: false,
    hpack: "fill",
    className: "slider-row",
    children: [
        SymbolicIcon({
            size: 24,
            icon: "brightness-symbolic",
        }),
        Widget.Slider({
            className: "horizontal",
            drawValue: false,
            value: BrightnessService.bind("brightness").as(b => b * 100),
            min: 0,
            max: 100,
            expand: true,
            onChange: (args: { value: number }) => BrightnessService.brightness = args.value / 100,
        })
    ]
});

export default Brightness;