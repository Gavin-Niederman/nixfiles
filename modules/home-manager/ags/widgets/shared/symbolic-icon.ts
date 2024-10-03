import { type IconProps } from "types/widgets/icon";

type SymbolicIconProps = Omit<IconProps, "className" | "class_name" | "classNames" | "class_names"> & {
    onClicked?: (() => void) | undefined
};

const SymbolicIcon = ({onClicked, ...props}: SymbolicIconProps) => Widget.Button({
    classNames: onClicked === undefined ? ["icon-container"] : ["icon-container", "hoverable"],
    child: Widget.Icon({
        className: "symbolic",
        ...props,
    }),
    setup: (self) => {
        if (onClicked !== undefined) {
            self.on_clicked = onClicked
        }
    }
})

export default SymbolicIcon;