const notifications = await Service.import("notifications");
import { Notification } from '../widgets/notification.js';

export const NotificationPopups = (monitor) =>
{
    return Widget.Window({
        monitor,
        name: 'notification-popup',
        exclusivity: "ignore",
        anchor: ["bottom", "right"],
        child: Widget.Box({
            css: "padding: 2px;",
            children: [Widget.Box({
                className: 'notifications',
                spacing: 10,
                vertical: true,
                vpack: "end",
                children: notifications.bind('popups').as(popups => { console.log(popups); return popups.map(Notification) }),
            })],
        }),
    });
}