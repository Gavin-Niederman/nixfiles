import { SymbolicIcon } from "widgets/shared";

const BatteryService = await Service.import("battery");

function level(percent: number) {
    /// A little bit of leeway
    if (percent >= 98) {
        return "full";
    } else if (percent > 60) {
        return "high";
    } else if (percent > 40) {
        return "medium";
    } else if (percent > 10) {
        return "low";
    } else {
        return "critical";
    }
}

const BatteryIcon = (icon: string) => SymbolicIcon({
    icon,
    size: 24
});

const Battery = (vertical: boolean) => Widget.Box({
    vertical,
    className: "battery",
    children: [
        Widget.Stack({
            transition: "slide_up",
            children: {
                "critical": BatteryIcon("bat-critical-symbolic"),
                "low": BatteryIcon("bat-low-symbolic"),
                "medium": BatteryIcon("bat-medium-symbolic"),
                "high": BatteryIcon("bat-high-symbolic"),
                "full": BatteryIcon("bat-full-symbolic"),
                "charging": BatteryIcon("bat-charging-symbolic"),
            },
            shown: Utils.merge([
                BatteryService.bind("percent").as(p => level(p)),
                BatteryService.bind("charging")],
                (level, charging) => charging ? "charging" : level
            ),
        }),
        Widget.Label({
            className: "percent-display",
            label: BatteryService.bind("percent").as(p => `${p.toFixed(0)}%`),
        }),
        Widget.LevelBar({
            vertical,
            inverted: true,
            barMode: "continuous",
            classNames: Utils.merge([
                BatteryService.bind("percent")
                    .as(p => ["battery-bar"]
                        .concat([vertical ? "vertical" : "horizontal"])
                        .concat(level(p))
                    ),
                BatteryService.bind("charging")
            ],
                (level, charging) => charging ? level.concat("charging") : level
            ),
            value: BatteryService.bind("percent").as(p => p / 100),
        })
    ]
})

export default Battery;