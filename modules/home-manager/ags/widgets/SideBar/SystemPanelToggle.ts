import { SymbolicIcon } from "widgets/shared";

const SystemPanelToggle = () => SymbolicIcon({
    icon: "gauge-symbolic",
    size: 24,
    onClicked: () => App.toggleWindow("system-panel")
});
export default SystemPanelToggle;