function formatTime(date: Date) {
    return Intl.DateTimeFormat('en-US', {
        dateStyle: undefined,
        timeStyle: "medium",
        hourCycle: "h24",
    }).format(date)
}

const time = Variable('', { poll: [1000, () => formatTime(new Date())] });
export default function Clock() {
    return Widget.Label({ label: time.bind() });
}