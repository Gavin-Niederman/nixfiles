import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import { Notification } from '../widgets/notification.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

export const NotificationPopup = Widget.Window({
    name: 'notification-popup',
    exclusivity: "ignore",
    anchor: ["bottom", "right"],
    child: Widget.Box({
        className: 'notifications',
        spacing: 10,
        vertical: true,
    })
    .hook(Notifications, box => {
        console.log(Notifications.popups);
        if (Notifications.popups.length === 0) {
            box.children = [];
            box.visible = false;
        }
        box.visible = true;
        App.openWindow('notification-popup');
        box.children = Notifications.popups.map(Notification);
    }),
});