def main [ ] {
    let windows = (hyprctl -j monitors | from json)
    $windows | each {|it| eww open bar --screen $it.id}

    null
}