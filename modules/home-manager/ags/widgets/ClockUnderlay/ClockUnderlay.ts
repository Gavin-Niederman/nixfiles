import Clock from "./Clock";

const ClockUnderlay = (monitor: number) => Widget.Window({
    monitor,
    name: `clock-underlay-${monitor}`,
    layer: "bottom",
    anchor: ["bottom", "right"],
    child: Clock(),
});

export default ClockUnderlay;