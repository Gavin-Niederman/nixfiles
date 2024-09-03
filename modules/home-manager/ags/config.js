const entry = App.configDir + "/main.ts"
const tmpdir = "/tmp/ags"

try {
    await Utils.execAsync([
        "bun", "build", entry,
        "--outdir", tmpdir + "/js",
        "--external", "resource://*",
        "--external", "gi://*",
    ])
    await Utils.execAsync([
        "dart-sass", `${App.configDir}/style/style.scss`, `${tmpdir}/style.css`
    ])
    await import(`file://${tmpdir}/js/main.js`)
} catch (error) {
    console.error(error)
}

// await needs this???
export {}