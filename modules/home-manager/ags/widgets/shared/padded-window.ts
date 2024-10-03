import { WindowProps } from "types/widgets/window";

type Location =
    | "top-right"
    | "top-left"
    | "bottom-right"
    | "bottom-left"
    | "middle-right"
    | "middle-left";
type PaddedWindowProps = WindowProps & {
    location: Location;
    paddingClass?: string;
};

const Padding = (expand: boolean, classNames: string[]) =>
    Widget.EventBox({
        canFocus: false,
        classNames,
        expand,
        setup: (w) =>
            w.on("button-press-event", () => App.closeWindow("quick-settings")),
    });

const PaddedWindow = ({
    child,
    location,
    paddingClass,
    ...props
}: PaddedWindowProps) =>
    Widget.Window({
        child: Widget.Box({
            children: [
                Padding(
                    location.includes("right"),
                    ["padding-left"].concat(paddingClass || []),
                ),
                Widget.Box({
                    vertical: true,
                    hexpand: false,
                    children: [
                        Padding(
                            location.includes("bottom") ||
                                location.includes("middle"),
                            ["padding-top"].concat(paddingClass || []),
                        ),
                        Widget.Box({ child }),
                        Padding(
                            location.includes("top") ||
                                location.includes("middle"),
                            ["padding-bottom"].concat(paddingClass || []),
                        ),
                    ],
                }),
                Padding(
                    location.includes("left"),
                    ["padding-right"].concat(paddingClass || []),
                ),
            ],
        }),
        ...props,
    });

export default PaddedWindow;
