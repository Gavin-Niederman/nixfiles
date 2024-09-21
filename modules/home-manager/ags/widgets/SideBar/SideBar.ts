import Workspaces from "./Workspaces";
import Windows from "./Windows";
import Battery from "./Battery";
import Audio from "./Audio";
import QuickSettingsToggle from "./QuickSettingsToggle";

const BatteryService = await Service.import("battery");

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
            endWidget: Widget.Box({
                vertical: true,
                vpack: "end",
                children: BatteryService.bind("available").as((available) => {
                    let widgets: any[] = [
                        QuickSettingsToggle(),
                        Widget.Separator({ vertical: true }),
                        Audio(true),
                    ];
                    if (available) {
                        widgets.push(Battery(true));
                    }

                    return widgets;
                }),
            })
        }),
        exclusivity: "exclusive",
    });
}

export default SideBar;