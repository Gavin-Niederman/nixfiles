const { execAsync } = ags.Utils;

export async function compileScss() {
    const path = ags.App.configDir;
    try {
        print(`Compiling SCSS to CSS in ${path}`)
        await execAsync(['sassc', `${path}/style/scss/main.scss`, `${path}/style.css`])
    } catch (error) {
        print(error);
    }
    return `${path}/style.css`;
}