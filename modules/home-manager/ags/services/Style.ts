class StyleService extends Service {
    static {
        Service.register(this, {
            "style-rebuilt": ["string"],
        },
            {
                "output-path": ["string", "rw"],
            }
        )
    }

    private outputPath: string;
    get output_path() {
        return this.outputPath;
    }
    set output_path(value: string) {
        this.outputPath = value;
        this.emit("output-path", value);
    }

    constructor(outputPath: string = "/tmp/ags/style.css") {
        super();
        this.outputPath = outputPath;

        const watcher = Utils.monitorFile(App.configDir + "/style/", async () => {
            await Utils.execAsync([
                "sass", `${App.configDir}/style/style.scss`, this.outputPath
            ]);
            this.emit("style-rebuilt", this.outputPath);
        });
        if (!watcher) {
            console.error("Failed to style file watcher! Something has gone horribly wrong...");
        }
    }
}

const Style = new StyleService();
export default Style;