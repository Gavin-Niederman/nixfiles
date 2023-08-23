import { Bar } from './shared.js';
import { Clock } from '../widgets/clock.js';
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
                Workspaces({})
            ],
        }),
        centerWidget: Box({
            children: [
                Clock({})
            ],
        })
    }),
});