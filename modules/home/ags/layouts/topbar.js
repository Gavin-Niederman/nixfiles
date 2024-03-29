import { Bar } from './shared.js';
import { Clock } from '../widgets/clock.js';
import { BatteryBar } from '../widgets/battery.js';
import { AudioBar } from '../widgets/audio.js';
import { Workspaces } from '../widgets/workspaces.js';
import { Separator } from '../widgets/separator.js';
import { Tray } from '../widgets/tray.js';
// import { Media } from '../widgets/media.js';

import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export const TopBar = (monitor) => Bar({
    monitor,
    name: "topbar",
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
        classNames: ['topbar', 'bar'],
        startWidget: Widget.Box({
            children: [
                Workspaces({monitor})
            ],
        }),
        centerWidget: Widget.Box({
            children: [
                Clock({})
            ],
        }),
        endWidget: Widget.Box({
            hpack: 'end',
            vpack: 'center',
            vexpand: false,
            hexpand: true,
            vertical: false,
            spacing: 15,
            children: [
                // Media({}),
                BatteryBar({}),
                AudioBar({}),
                Tray({}),
            ],
        })
    }),
});