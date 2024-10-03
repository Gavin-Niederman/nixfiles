import { Style } from "services";
import Clock from "./clock";

const ClockUnderlay = (monitor: number) =>
    Widget.Window({
        monitor,
        name: `clock-underlay-${monitor}`,
        className: Style.bind("flavor").as(
            (flavor) =>
                `clock-underlay-${flavor === "latte" ? "light" : "dark"}`,
        ),
        layer: "bottom",
        anchor: ["bottom", "right"],
        child: Clock(),
    });

export default ClockUnderlay;
