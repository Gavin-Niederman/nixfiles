import { ToggleButton } from "./ToggleButton";

const PowerProfiles = await Service.import('powerprofiles')

const PowerProfile = () => ToggleButton({
    child: Widget.Box({
        children: [
            Widget.Label({
                hexpand: true,
                hpack: "start",
                label: PowerProfiles.bind("active_profile"),
            }),
            Widget.Icon({
                hpack: "end",
                icon: "caret-right-symbolic",
                size: 24,
            })
        ]
    }),
});

export default PowerProfile;