import { Niri } from "services";

const Workspace = (idx: number, active: boolean) =>
  Widget.Button({
    classNames: active ? ["workspace", "active"] : ["workspace"],
    hexpand: false,
    onClicked: () => {
      Niri.messageAsync(["action", "focus-workspace", idx.toString()]);
    },
  });

const Workspaces = (output: string, vertical: boolean) =>
  Widget.Box({
    vertical,
    hpack: "center",
    className: "workspaces",
    children: Niri.bind("workspaces").as((workspaces) =>
      workspaces
        .filter((w) => w.output === output)
        .sort((a, b) => a.idx - b.idx)
        .map((workspace) => Workspace(workspace.idx, workspace.is_active)),
    ),
  });

export default Workspaces;
