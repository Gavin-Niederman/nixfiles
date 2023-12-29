import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import { Notification } from '../widgets/notification.js';

export const NotificationPopup = Widget.Window({
    name: 'notification-popup',
    exclusivity: "ignore",
    anchor: ["top", "right"],
    child: Widget.Box({
        className: 'notifications',
        spacing: 10,
        vertical: true,
        children: Notifications.bind('popups').transform(popups => popups.map(Notification)),
    }),
});