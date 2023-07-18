def main [ num_workspaces: int ] {
    let workspaces = (hyprctl -j workspaces | from json)
    let workspace_states = (1..$num_workspaces | each {|it| {id: $it, focused: false, full: ()}} )
    
    print $workspace_states 
    print "\n"
    print $workspaces

    null
}