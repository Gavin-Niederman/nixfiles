def main [ ] {
    let windows = (hyprctl -j monitors | from json)
    $windows | each {|it| eww open $it.name --force-wayland}

    null
}