const notifications = await Service.import("notifications");
import { Notification } from '../widgets/notification.js';

export const NotificationPopups = (monitor) =>
{
    return Widget.Window({
        monitor,
        name: 'notification-popup',
        exclusivity: "ignore",
        anchor: ["top", "right"],
        click_through: true,
        child: Widget.Box({
            click_through: true,
            css: "min-width: 2px; min-height: 2px;",
            children: [Widget.Box({
                className: 'notifications',
                spacing: 10,
                vertical: true,
                children: notifications.bind('popups').as(popups => { console.log(popups); return popups.map(Notification) }),
            })],
        }),
    });
}