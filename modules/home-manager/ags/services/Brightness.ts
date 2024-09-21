class BrightnessService extends Service {
    static {
        Service.register(this, {
            "brightness-changed": ["float"],
        },
            {
                "brightness": ["float", "rw"],
            }
        )
    }

    private _brightness: number;

    get brightness() {
        return this._brightness;
    }
    set brightness(value: number) {
        Math.max(0, Math.min(1, value));
        this._brightness = value;

        Utils.execAsync(["brightnessctl", "s", `${value * 100}%`]);
    }

    private readonly currentBrightness: () => Promise<number> = async () => {
        return Number(await Utils.execAsync(["brightnessctl", "g"]));
    };

    constructor() {
        super();

        const maxBrightness = Number(Utils.exec(["brightnessctl", "m"]));
        this._brightness = Number(Utils.exec(["brightnessctl", "g"])) / maxBrightness;

        const device = Utils.exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");
        Utils.monitorFile(`/sys/class/backlight/${device}/brightness`, async () => {
            const currentBrightness = await this.currentBrightness();
            this._brightness = currentBrightness / maxBrightness;
            this.emit("brightness-changed", this._brightness);
            this.notify("brightness");
            this.emit("changed");
        });
    }
}

const Brightness = new BrightnessService();
export default Brightness;