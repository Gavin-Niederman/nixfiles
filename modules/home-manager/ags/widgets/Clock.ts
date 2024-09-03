const time = Variable('', { poll: [1000, () => new Date().toLocaleTimeString()] });
export default function Clock() {
    return Widget.Label({ label: time.bind() });
}