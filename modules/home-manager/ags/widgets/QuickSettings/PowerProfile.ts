import LargeButton from "./LargeButton";

const PowerProfiles = await Service.import('powerprofiles')

const PowerProfile = () => LargeButton({
    child: Widget.Box({
        children: [
            Widget.Label({
                label: PowerProfiles.bind("active_profile"),
            }),
            Widget.Icon({
                icon: "caret-right-symbolic",
                size: 24,
            })
        ]
    }),
});

export default PowerProfile;