import Gtk from "gi://Gtk";
import { BindableProps, Binding } from "types/service";

type ToggleButtonProps<ToggleButtonChild extends Gtk.Widget, RevealerChild extends Gtk.Widget> = BindableProps<{
    toggleButtonContent: ToggleButtonChild;
    revealerContent: RevealerChild;
}>

export function ToggleButton<ToggleButtonChild extends Gtk.Widget, RevealerChild extends Gtk.Widget>(props: ToggleButtonProps<ToggleButtonChild, RevealerChild>) {
    const revealer = Widget.Revealer({
        child: Widget.Box({
            className: "revealer-content-container",
            child: props.revealerContent,
        }),
    });
    
    const toggleButton = Widget.Box({
        children: [
            Widget.Button({
                className: "toggle-button-toggle toggle-button-child",
                child: props.toggleButtonContent,
                hexpand: true,
            }),
            Widget.Button({
                className: "toggle-button-dropdown toggle-button-child",
                child: Widget.Icon({
                    icon: "caret-right-symbolic",
                    size: 24,
                }),
                onClicked: (self) => {
                    revealer.revealChild = !revealer.revealChild;
                    self.toggleClassName("dropped", revealer.revealChild);
                }
            })
        ],
    });

    return Widget.Box({
        className: "toggle-button",
        vertical: true,
        children: [
            toggleButton,
            revealer,
        ]
    })
};