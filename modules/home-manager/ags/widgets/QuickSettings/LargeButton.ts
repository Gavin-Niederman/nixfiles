import { ButtonProps } from "types/widgets/button";

export type LargeButtonProps = Omit<ButtonProps, "class_name" | "className" | "class_names" | "classNames">

const LargeButton = (props: LargeButtonProps) => Widget.Button({
    className: "large-button",
    ...props,
});

export default LargeButton;