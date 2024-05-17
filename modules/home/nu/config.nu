$env.config = {
    show_banner: false,
    completions: {
        case_sensitive: false,
        quick: true,
        partial: true,
        algorithm: 'fuzzy',
        external: {
            enable: true,
        }
    }
}
mkdir $"($env.HOME)/.config/idle"
let idle_enable_path = $"($env.HOME)/.config/idle/idle_enable"
touch $idle_enable_path

def "idle disable" [] {
    "false" | save -f $idle_enable_path
}
def "idle enable" [] {
    "true" | save -f $idle_enable_path
}

if (cat $idle_enable_path) == "" {
    idle enable
}

def "idle status" [] {
    return (cat $idle_enable_path | into bool)
}

def "idle unwrap" [] {
    if (idle status) {
        echo "idle is enabled"
    } else {
        error make {
            msg: "idle is disabled"
        }
    }
}

alias z = zoxide
alias f = zoxide