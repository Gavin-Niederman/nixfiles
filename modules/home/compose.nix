{
  # Custom Compose sequences, on top of the locale defaults. Caps Lock is the
  # Compose key, see niri.nix. Read by libxkbcommon (Wayland apps) and GTK.
  home.file.".XCompose".text = ''
    include "%L"

    # Set operators
    <Multi_key> <parenleft> <equal> <equal> : "∈" U2208 # ELEMENT OF
    <Multi_key> <parenleft> <equal> <slash> : "∉" U2209 # NOT AN ELEMENT OF
    <Multi_key> <parenright> <equal> <equal> : "∋" U220B # CONTAINS AS MEMBER
    <Multi_key> <parenright> <equal> <slash> : "∌" U220C # DOES NOT CONTAIN AS MEMBER
    <Multi_key> <parenleft> <less> <less> : "⊂" U2282 # SUBSET OF
    <Multi_key> <parenleft> <less> <equal> : "⊆" U2286 # SUBSET OF OR EQUAL TO
    <Multi_key> <parenleft> <less> <slash> : "⊄" U2284 # NOT A SUBSET OF
    <Multi_key> <parenleft> <greater> <greater> : "⊃" U2283 # SUPERSET OF
    <Multi_key> <parenleft> <greater> <equal> : "⊇" U2287 # SUPERSET OF OR EQUAL TO
    <Multi_key> <parenleft> <greater> <slash> : "⊅" U2285 # NOT A SUPERSET OF
    <Multi_key> <backslash> <backslash> : "∖" U2216 # SET MINUS
    <Multi_key> <u> <n> : "∪" U222A # UNION
    <Multi_key> <u> <i> : "∩" U2229 # INTERSECTION, replaces ĭ
    <Multi_key> <u> <c> : "∁" U2201 # COMPLEMENT
    <Multi_key> <u> <d> : "∆" U2206 # INCREMENT, used for symmetric difference
  '';
}
