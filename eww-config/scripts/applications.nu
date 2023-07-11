export def get-apps [] {
    let data_dirs = ($env.XDG_DATA_DIRS | split row ":" | where ($it | path exists))

    let applications = ($data_dirs | each { |it|
        cd $it;
        ls **/* -s | each {|link| $link.name} | where ($it ends-with ".desktop")
    } | flatten)

    $applications | each {|it| $it | split column ".desktop" } | flatten | each { |it| ($it).column1 } | to json
}

export def search [query: string, --max-dist: int = 10] {
    let apps = (each {|it| 
        {string: $it, distance: ($it | str distance $query)}
    })

    let apps = ($apps | where ($it.distance < $max_dist))

    let apps = ($apps | sort-by distance | get string)

    $apps | to json
}