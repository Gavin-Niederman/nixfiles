import Gtk from "gi://Gtk";

function formatTime(date: Date) {
    return Intl.DateTimeFormat('en-US', {
        dateStyle: undefined,
        timeStyle: "medium",
        hourCycle: "h24",
    }).format(date)
}

function formatDate(date: Date) {
    return Intl.DateTimeFormat('en-US', {
        dateStyle: "full",
        timeStyle: undefined,
    }).format(date)
}

const date = Variable(new Date(), { poll: [1000, () => new Date()] });
const Clock = () => Widget.Box({
    className: "clock",
    vertical: true,
    children: [
        Widget.Label({ className: "time", label: date.bind().as(time => formatTime(time)) }),
        Widget.Label({ className: "date", hpack: "start", label: date.bind().as(date => formatDate(date)) }),
    ],
});

export default Clock;