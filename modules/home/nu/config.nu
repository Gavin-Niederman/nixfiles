let carapace_completer = {|spans|
    carapace $spans.0 nushell $spans | from json
}

$env.config = {
    show_banner: false,
    completions: {
        case_sensitive: false,
        quick: true,
        partial: true,
        algorithm: 'fuzzy',
        external: {
            enable: true,
            completer: $carapace_completer
        }
    }
}