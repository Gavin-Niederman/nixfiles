import Clock from "widgets/Clock";

function TopBar(monitor: number) {
    return Widget.Window({
        monitor,
        name: `topbar-${monitor}`,
        anchor: ["top", "left", "right"],
        layer: "top",
        child: Widget.CenterBox({
            centerWidget: Clock(),
        }),
        exclusivity: "exclusive",
    });
}

export default TopBar;