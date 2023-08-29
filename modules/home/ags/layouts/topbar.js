import { Bar } from './shared.js';
import { Clock } from '../widgets/clock.js';
import { Battery } from '../widgets/battery.js';
import { Audio } from '../widgets/audio.js';
import { Workspaces } from '../widgets/workspaces.js';
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
            children: ags.Service.Battery.availible ? [
                Battery({}),
                Audio({}),
            ]: [
                Audio({}),
            ],
        })
    }),
});