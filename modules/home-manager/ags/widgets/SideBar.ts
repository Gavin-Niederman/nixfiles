import Clock from "widgets/Clock";
import Workspaces from "widgets/Workspaces";
import Windows from "widgets/Windows";
import Niri from "services/Niri";

function SideBar(monitor: number, output: string) {
    return Widget.Window({
        monitor,
        name: `sidebar-${monitor}`,
        anchor: ["left", "top", "bottom"],
        layer: "top",
        child: Widget.CenterBox({
            vertical: true,
            className: "sidebar-container",
            startWidget: Widget.Box({
                vertical: true,
                children: [
                    Workspaces(output, true),
                    Windows()
                ]
            }),
        }),
        exclusivity: "exclusive",
    });
}

export default SideBar;