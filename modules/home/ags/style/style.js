const { exec } = ags.Utils;

export function compileScss() {
    const path = ags.App.configDir;
    // We cant write to the config dir because of home manager
    const output = '/home/gavin/.ags/style.css';
    try {
        print(`Compiling SCSS to CSS in ${path}`)
        exec('mkdir -p /home/gavin/.ags');
        // exec(`rm ${output}`);
        exec(`sassc ${path}/style/scss/main.scss ${output}`)
    } catch (error) {
        print(error);
    }
    return output;
}