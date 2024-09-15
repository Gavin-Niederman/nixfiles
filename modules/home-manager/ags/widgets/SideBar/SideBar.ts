import Workspaces from "./Workspaces";
import Windows from "./Windows";

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
                    Widget.Separator({ vertical: true }),
                    Windows()
                ]
            }),
        }),
        exclusivity: "exclusive",
    });
}

export default SideBar;