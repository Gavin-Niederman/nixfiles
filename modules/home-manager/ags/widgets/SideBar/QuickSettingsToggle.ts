import { SymbolicIcon } from "widgets";

const QuickSettingsToggle = () => SymbolicIcon({
    icon: "settings-symbolic",
    size: 24,
    onClicked: () => App.toggleWindow("quick-settings")
});
export default QuickSettingsToggle;