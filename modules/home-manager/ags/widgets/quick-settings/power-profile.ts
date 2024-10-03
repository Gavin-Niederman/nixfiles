import { ToggleButton } from "./toggle-button";

const PowerProfiles = await Service.import("powerprofiles");

function renameProfile(profile: string) {
    return profile.charAt(0).toUpperCase() + profile.slice(1);
}

const ProfileOption = (profile: string) => {
    return Widget.Button({
        hpack: "start",
        hexpand: true,
        classNames: PPSelected.bind()
            .as(active => active == profile)
            .as(active => active ? ["active", "toggle-button-dropdown-option"] : ["toggle-button-dropdown-option"]),
        label: renameProfile(profile),
        onClicked: () => PPSelected.value = profile,
    })
};

const PPEnabled = Variable(true);
const PPSelected = Variable(PowerProfiles.active_profile);

PPSelected.connect("changed", ({value}) => {
    if (PPEnabled.value) {
        PowerProfiles.active_profile = value;
    }
})

const PowerProfile = () => ToggleButton({
    toggleButtonContent: Widget.Box({
        spacing: 8,
        hpack: "start",
        className: "power-profile-label",
        hexpand: true,
        children: [
            Widget.Icon({
                icon: "gauge-symbolic",
                size: 24,
            }),
            Widget.Label({
                hpack: "start",
                vpack: "center",
                vexpand: true,
                label: PPSelected.bind().as(renameProfile),
            })
        ]
    }),
    revealerContent: Widget.Box({
        vertical: true,
        spacing: 8,
        children: PowerProfiles.bind("profiles")
            .as(profiles => profiles.map(
                profile => ProfileOption(profile.Profile))
            ),
    }),
    onToggleClicked: () => {
        PPEnabled.value = !PPEnabled.value;
        if (!PPEnabled.value) {
            PowerProfiles.active_profile = "balanced";
        } else {
            PowerProfiles.active_profile = PPSelected.value;
        }
    },
    toggled: PPEnabled.bind(),
});

export default PowerProfile;