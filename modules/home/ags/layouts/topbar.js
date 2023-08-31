import { Bar } from './shared.js';
import { Clock } from '../widgets/clock.js';
import { Battery } from '../widgets/battery.js';
import { Audio } from '../widgets/audio.js';
import { Workspaces } from '../widgets/workspaces.js';
import { Separator } from '../widgets/separator.js';

const { Box, CenterBox } = ags.Widget;

export const TopBar = (monitor) => Bar({
    monitor,
    name: "topbar",
    anchor: ["top", "left", "right"],
    child: CenterBox({
        className: ['topbar', 'bar'],
        startWidget: Box({
            children: [
                Workspaces({monitor})
            ],
        }),
        centerWidget: Box({
            children: [
                Clock({})
            ],
        }),
        endWidget: Box({
            halign: 'end',
            children: ags.Service.Battery.available ? [
                Battery({}),
                Separator({}),
                Audio({}),
            ]: [
                Audio({}),
            ],

            properties: [
                ['containsBattery', false]
            ],

            // This is required because the available property of the Battery service is sometimes false for a while even on systems with a battery
            connections: [
                [
                    ags.Service.Battery,
                    box => {
                        if (!box.containsBattery_ && ags.Service.Battery.available) {
                            box.children = [
                                Battery({}),
                                Separator({}),
                                Audio({}),
                            ];
                            box.containsBattery_ = true;
                        }
                    },
                    'changed'
                ]
            ]
        })
    }),
});