import NiriService from "services/Niri";
import Clock from "widgets/Clock";
import Workspaces from "widgets/Workspaces";

function TopBar(monitor: number, output: string) {
    return Widget.Window({
        monitor,
        name: `topbar-${monitor}`,
        anchor: ["top", "left", "right"],
        layer: "top",
        child: Widget.CenterBox({
            className: "topbar-container",
            centerWidget: Clock(),
            startWidget: Workspaces(output),
        }),
        exclusivity: "exclusive",
    });
}

export default TopBar;