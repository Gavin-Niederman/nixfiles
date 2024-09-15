import Niri from "services/Niri";

const Window = (icon: string, id: number, focused: boolean) => {
    console.log(icon);
    return Widget.Button({
    classNames: focused ? ["window", "focused"] : ["window"],
    child: Widget.Icon({ icon, size: 16 }),
    onClicked: () => {
        Niri.messageAsync(["action", "focus-window", "--id", id.toString()]);
    },
})};

const Windows = () => Widget.Box({
    className: "windows",
    vertical: true,
    hpack: "center",
    children: Niri.bind("windows").as(windows => {
        return windows
            .map(window => Window(window.app_id ?? "application-default", window.id, window.is_focused))
    })
});

export default Windows;