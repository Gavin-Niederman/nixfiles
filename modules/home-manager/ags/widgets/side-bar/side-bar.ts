import Workspaces from "./workspaces";
import Windows from "./windows";
import Battery from "./battery";
import { Audio, Dummy } from "widgets";
import QuickSettingsToggle from "./quick-settings-toggle";

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
                children: BatteryService.bind("available").as((available) => [
                        QuickSettingsToggle(),
                        Widget.Separator({ vertical: true }),
                        Audio(true),
                        available ? Battery(true) : Dummy()
                    ]),
            })
        }),
        exclusivity: "exclusive",
    });
}

export default SideBar;