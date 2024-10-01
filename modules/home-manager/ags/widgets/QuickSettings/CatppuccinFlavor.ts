import { Style } from "services";
import { ToggleButton } from "./ToggleButton";

const Flavor = Variable(Style.flavor);
const DarkMode = Variable(Style.flavor !== "latte");

Flavor.connect("changed", ({ value }) => {
    if (DarkMode.value) {
        Style.flavor = value as "macchiato" | "latte" | "frappe" | "mocha";
    }
})

const flavors = {
    "frappe": "Frappé",
    "macchiato": "Macchiato",
    "mocha": "Mocha",
};

const FlavorOption = (flavor: "macchiato" | "latte" | "frappe" | "mocha") => Widget.Button({
    hpack: "start",
    hexpand: true,
    classNames: Flavor.bind()
        .as(selected => selected === flavor)
        .as(active => active ? ["active", "toggle-button-dropdown-option"] : ["toggle-button-dropdown-option"]),
    label: flavors[flavor],
    onClicked: () => Flavor.value = flavor,
});

const CatppuccinFlavor = () => ToggleButton({
    toggleButtonContent: Widget.Box({
        spacing: 8,
        hpack: "start",
        className: "theme-label",
        hexpand: true,
        children: [
            Widget.Icon({
                icon: "theme-symbolic",
                size: 24,
            }),
            Widget.Label({
                hpack: "start",
                vpack: "center",
                vexpand: true,
                label: "Dark Mode",
            })
        ]
    }),
    revealerContent: Widget.Box({
        vertical: true,
        spacing: 8,
        children: Object.keys(flavors).map(flavor => FlavorOption(flavor as "macchiato" | "latte" | "frappe" | "mocha")),
    }),

    onToggleClicked: () => {
        DarkMode.value = !DarkMode.value;
        if (!DarkMode.value) {
            Style.flavor = "latte";
        } else {
            if (Flavor.value === "latte") {
                Flavor.value = "macchiato";
            };
            Style.flavor = Flavor.value as "macchiato" | "latte" | "frappe" | "mocha";
        }
    },
    toggled: DarkMode.bind(),
});

export default CatppuccinFlavor;