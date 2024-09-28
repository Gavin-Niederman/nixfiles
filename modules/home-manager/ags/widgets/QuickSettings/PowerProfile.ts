import { ToggleButton } from "./ToggleButton";

const PowerProfiles = await Service.import('powerprofiles')

const PowerProfile = () => ToggleButton({
    toggleButtonContent: Widget.Label({
        hexpand: true,
        hpack: "start",
        label: PowerProfiles.bind("active_profile"),
    }),
    revealerContent: Widget.Box({
        css: "padding: 32px;",
    }),
});

export default PowerProfile;