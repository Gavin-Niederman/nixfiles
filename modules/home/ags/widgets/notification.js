import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { lookUpIcon } from 'resource:///com/github/Aylur/ags/utils.js';

const NotificationIcon = ({ app_entry, app_icon, image }) => {
    if (image) {
        return Widget.Box({
            css: `
                background-image: url("${image}");
                background-size: contain;
                background-repeat: no-repeat;
                background-position: center;
            `,
        });
    }

    let icon = 'dialog-information-symbolic';
    if (lookUpIcon(app_icon))
        icon = app_icon;

    if (app_entry && lookUpIcon(app_entry))
        icon = app_entry;

    return Widget.Icon(icon);
};

export const Notification = notification => {
    const icon = NotificationIcon(notification);
    const summary = Widget.Label({
        className: 'notif-summary',
        label: notification.summary,
    });
    const body = Widget.Label({
        className: 'notif-body',
        label: notification.body,
        use_markup: true,
        wrap: true,
        justification: 'left',
    });
    const actions = Widget.Box({
        class_name: 'notif-actions',
        children: notification.actions.map(({ id, label }) => Widget.Button({
            class_name: 'notif-action-button',
            on_clicked: () => notification.invoke(id),
            hexpand: true,
            child: Widget.Label(label),
        })),
    });

    return Widget.EventBox({
        on_primary_click: () => notification.invoke('default'),
        on_secondary_click: () => notification.dismiss(),
        child: Widget.Box({
            classNames: ['notification', `notif-${notification.urgency}`],
            vertical: true,
            children: [
                Widget.Box({
                    children: [
                        icon,
                        Widget.Box({
                            vertical: true,
                            children: [
                                summary,
                                body,
                            ],
                        }),
                    ],
                }),
                actions,
            ],
        }),
    })
}