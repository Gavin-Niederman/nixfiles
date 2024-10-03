class BrightnessService extends Service {
    static {
        Service.register(
            this,
            {
                "brightness-changed": ["float"],
            },
            {
                brightness: ["float", "rw"],
                available: ["boolean", "r"],
            },
        );
    }

    private _brightness: number;
    private readonly device = Utils.exec(
        "sh -c 'ls -w1 /sys/class/backlight | head -1'",
    );

    get brightness() {
        return this._brightness;
    }
    set brightness(value: number) {
        Math.max(0, Math.min(1, value));
        this._brightness = value;

        Utils.execAsync(["brightnessctl", "s", `${value * 100}%`]);
    }

    private _available: boolean;
    get available() {
        return this._available;
    }

    private readonly currentBrightness: () => Promise<number> = async () => {
        return Number(await Utils.execAsync(["brightnessctl", "g"]));
    };

    constructor() {
        super();

        this._available = this.device !== "";
        this.notify("available");
        this._brightness = -1;

        if (!this._available) return;
        const maxBrightness = Number(Utils.exec(["brightnessctl", "m"]));
        this._brightness =
            Number(Utils.exec(["brightnessctl", "g"])) / maxBrightness;

        Utils.monitorFile(
            `/sys/class/backlight/${this.device}/brightness`,
            async () => {
                const currentBrightness = await this.currentBrightness();
                this._brightness = currentBrightness / maxBrightness;
                this.emit("brightness-changed", this._brightness);
                this.notify("brightness");
                this.emit("changed");
            },
        );
    }
}

const Brightness = new BrightnessService();
export default Brightness;
