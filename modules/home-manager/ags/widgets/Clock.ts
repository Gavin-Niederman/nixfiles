function formatTime(date: Date) {
    return Intl.DateTimeFormat('en-US', {
        dateStyle: undefined,
        timeStyle: "medium",
        hourCycle: "h24",
    }).format(date)
}

const time = Variable('', { poll: [1000, () => formatTime(new Date())] });
const Clock = () => Widget.Box({
    className: "clock",
    children: [
        Widget.Icon({ icon: "clock" }),
        Widget.Label({ label: time.bind() })
    ],
});

export default Clock;