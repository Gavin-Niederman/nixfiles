import Gtk from "gi://Gtk";
import { Binding } from "types/service";
import { ButtonProps } from "types/widgets/button";

export type ToggleButtonProps = Omit<ButtonProps, "class_name" | "className" | "class_names" | "classNames">

function ButtonWrapper<Child extends Gtk.Widget>(child: Child, toggled: Binding<any, any, boolean> | boolean) {
    return Widget.Box({
        className: "toggle-button-wrapper",
        child
    })
}

export const ToggleButton = (props: ToggleButtonProps) => Widget.Button({
    className: "large-button",
    ...props,
});