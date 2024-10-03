const macchiato = {
  rosewater: "#f4dbd6",
  flamingo: "#f0c6c6",
  pink: "#f5bde6",
  mauve: "#c6a0f6",
  red: "#ed8796",
  maroon: "#ee99a0",
  peach: "#f5a97f",
  yellow: "#eed49f",
  green: "#a6da95",
  teal: "#8bd5ca",
  sky: "#91d7e3",
  sapphire: "#7dc4e4",
  blue: "#8aadf4",
  lavender: "#b7bdf8",

  text: "#cad3f5",
  "subtext-1": "#b8c0e0",
  "subtext-0": "#a5adcb",

  "overlay-2": "#939ab7",
  "overlay-1": "#8087a2",
  "overlay-0": "#6e738d",

  "surface-2": "#5b6078",
  "surface-1": "#494d64",
  "surface-0": "#363a4f",

  base: "#24273a",
  mantle: "#1e2030",
  crust: "#181926",
};

const frappe = {
  rosewater: "#f2d5cf",
  flamingo: "#eebebe",
  pink: "#f4b8e4",
  mauve: "#ca9ee6",
  red: "#e78284",
  maroon: "#ea999c",
  peach: "#ef9f76",
  yellow: "#e5c890",
  green: "#a6d189",
  teal: "#81c8be",
  sky: "#99d1db",
  sapphire: "#85c1dc",
  blue: "#8caaee",
  lavender: "#babbf1",

  text: "#c6d0f5",
  "subtext-1": "#b5bfe2",
  "subtext-0": "#a5adce",

  "overlay-2": "#949cbb",
  "overlay-1": "#838ba7",
  "overlay-0": "#737994",

  "surface-2": "#626880",
  "surface-1": "#51576d",
  "surface-0": "#414559",

  base: "#303446",
  mantle: "#292c3c",
  crust: "#232634",
};

const mocha = {
  rosewater: "#f5e0dc",
  flamingo: "#f2cdcd",
  pink: "#f5c2e7",
  mauve: "#cba6f7",
  red: "#f38ba8",
  maroon: "#eba0ac",
  peach: "#fab387",
  yellow: "#f9e2af",
  green: "#a6e3a1",
  teal: "#94e2d5",
  sky: "#89dceb",
  sapphire: "#74c7ec",
  blue: "#89b4fa",
  lavender: "#b4befe",

  text: "#cdd6f4",
  "subtext-1": "#bac2de",
  "subtext-0": "#a6adc8",

  "overlay-2": "#9399b2",
  "overlay-1": "#7f849c",
  "overlay-0": "#6c7086",

  "surface-2": "#585b70",
  "surface-1": "#45475a",
  "surface-0": "#313244",

  base: "#1e1e2e",
  mantle: "#181825",
  crust: "#11111b",
};

const latte = {
  rosewater: "#dc8a78",
  flamingo: "#dd7878",
  pink: "#ea76cb",
  mauve: "#8839ef",
  red: "#d20f39",
  maroon: "#e64553",
  peach: "#fe640b",
  yellow: "#df8e1d",
  green: "#40a02b",
  teal: "#179299",
  sky: "#04a5e5",
  sapphire: "#209fb5",
  blue: "#1e66f5",
  lavender: "#7287fd",

  text: "#4c4f69",
  "subtext-1": "#5c5f77",
  "subtext-0": "#6c6f85",

  "overlay-2": "#7c7f93",
  "overlay-1": "#8c8fa1",
  "overlay-0": "#9ca0b0",

  "surface-2": "#acb0be",
  "surface-1": "#bcc0cc",
  "surface-0": "#ccd0da",

  base: "#eff1f5",
  mantle: "#e6e9ef",
  crust: "#dce0e8",
};

const flavors = {
  macchiato: macchiato,
  latte: latte,
  frappe: frappe,
  mocha: mocha,
};

function colorsScss(flavor: "macchiato" | "latte" | "frappe" | "mocha") {
  const colors = flavors[flavor];
  return Object.keys(colors)
    .map((key) => `$${key}: ${colors[key]};`)
    .join("\n");
}
function variablsScss(flavor: "macchiato" | "latte" | "frappe" | "mocha") {
  return (
    colorsScss(flavor) +
    `
        $corner-radius: 16px;
        $ui-radius: 8px;
        $transition: all 0.2s;
    `
  );
}

class StyleService extends Service {
  static {
    Service.register(
      this,
      {
        "style-rebuilt": ["string"],
      },
      {
        "output-path": ["string", "rw"],
        flavor: ["string", "rw"],
      },
    );
  }

  private outputPath: string;
  get output_path() {
    return this.outputPath;
  }
  set output_path(value: string) {
    this.outputPath = value;
    this.notify("output-path");
    this.emit("changed");
  }

  private _flavor: keyof typeof flavors = "macchiato";
  get flavor() {
    return this._flavor;
  }
  set flavor(value: "macchiato" | "latte" | "frappe" | "mocha") {
    this._flavor = value;
    this.notify("flavor");
    this.emit("changed");
    this.buildStyle();
  }

  constructor(outputPath: string = "/tmp/ags/style.css") {
    super();
    this.outputPath = outputPath;

    const watcher = Utils.monitorFile(
      App.configDir + "/style/",
      async () => await this.buildStyle(),
    );
    if (!watcher) {
      console.error(
        "Failed to style file watcher! Something has gone horribly wrong...",
      );
    }
  }

  async buildStyle() {
    const variables = variablsScss(this._flavor);

    const scssFiles = (
      await Utils.execAsync(`fd .scss ${App.configDir}`)
    ).split(/\n+/);
    const imports = ["/tmp/ags/variables.scss", ...scssFiles]
      .map((file) => `@import "${file}";`)
      .join("\n");

    await Utils.writeFile(variables, "/tmp/ags/variables.scss");
    await Utils.writeFile(imports, "/tmp/ags/style.scss");

    await Utils.execAsync(["sass", `/tmp/ags/style.scss`, this.outputPath]);
    this.emit("style-rebuilt", this.outputPath);
  }
}

const Style = new StyleService();
export default Style;
