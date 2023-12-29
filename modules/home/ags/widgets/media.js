import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';

const PlayerButton = (action, icon, player) => Widget.Button({
    className: 'player-button',
    child: Widget.Icon(icon),
    on_clicked: () => action(player),
})

const Player = player => Widget.CenterBox({
    className: 'player',
    startWidget: PlayerButton(
        (player) => player.previous(),
        'media-skip-backward-symbolic',
        player
    ),
    centerWidget: PlayerButton(
        (player) => player.playPause(),
        'media-playback-start-symbolic',
        player
    ),
    endWidget: PlayerButton(
        (player) => player.next(),
        'media-skip-forward-symbolic',
        player
    ),
});

export const Media = ({ }) => Widget.Box()
    .hook(
        Mpris,
        box => box.children = Mpris.players.map(player => Player(player))
    )