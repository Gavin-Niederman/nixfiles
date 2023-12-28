import { exec } from 'resource:///com/github/Aylur/ags/utils.js';
import App from 'resource:///com/github/Aylur/ags/app.js';

export function compileScss() {
    const path = App.configDir;
    // We cant write to the config dir because of home manager
    const output = '/home/gavin/.cache/ags/style.css';
    try {
        print(`Compiling SCSS to CSS in ${path}`)
        exec('mkdir -p /home/gavin/.cache/ags/');
        // exec(`rm ${output}`);
        exec(`sassc ${path}/style/scss/main.scss ${output}`)
    } catch (error) {
        print(error);
    }
    return output;
}