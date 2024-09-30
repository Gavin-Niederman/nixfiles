const LogoutMenuOption = (icon: string, action: () => void) => Widget.Button({
    className: "logout-menu-option",
    child: Widget.Icon({ icon, size: 128 }),
    onPrimaryClickRelease: () => {
        action();
        App.closeWindow("logout-menu");
    }
})

const LogoutMenu = () => Widget.Window({
    name: "logout-menu",
    anchor: ["top", "bottom", "left", "right"],
    layer: "overlay",
    exclusivity: "ignore",
    keymode: "exclusive",
    expand: true,
    visible: false,
    className: "logout-menu",
    child: Widget.Box({
        expand: true,
        vpack: "center",
        hpack: "center",
        child: Widget.Box({
            vertical: true,
            spacing: 32,
            children: [
                Widget.Box({
                    spacing: 32,
                    children: [
                        LogoutMenuOption("circular-arrow-symbolic", () => Utils.exec("systemctl reboot")),
                        LogoutMenuOption("power-symbolic", () => Utils.exec("systemctl poweroff")),
                        LogoutMenuOption("logout-symbolic", () => Utils.exec("niri msg action quit")),
                    ]
                }),
                Widget.Box({
                    spacing: 32,
                    children: [
                        LogoutMenuOption("hibernate-symbolic", () => Utils.exec("systemctl hibernate")),
                        LogoutMenuOption("lock-symbolic", () => Utils.exec("loginctl lock-session")),
                        LogoutMenuOption("sleep-symbolic", () => Utils.exec("systemctl suspend")),
                    ]
                })
            ]
        }),
    })
}).keybind("Escape", () => App.closeWindow("logout-menu"));

export default LogoutMenu;