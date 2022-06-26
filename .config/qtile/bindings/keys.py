from libqtile import layout
from libqtile.lazy import lazy
from libqtile.config import Key

from personal import *

def get(groups):
    keys = [
        # Move focus
        Key([MOD, 'control'], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([MOD, 'control'], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([MOD, 'control'], "j", lazy.layout.down(), desc="Move focus down"),
        Key([MOD, 'control'], "k", lazy.layout.up(), desc="Move focus up"),

        # Move windows
        Key([MOD, "shift"], "h", lazy.layout.swap_left(), desc="Move window to the left"),
        Key([MOD, "shift"], "l", lazy.layout.swap_right(), desc="Move window to the right"),
        Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

        # Resize windows
        Key([MOD], "h", lazy.layout.grow(), desc="Grow window to the left"),
        Key([MOD], "l", lazy.layout.shrink(), desc="Grow window to the right"),
        Key([MOD], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([MOD], "k", lazy.layout.grow_up(), desc="Grow window up"),
        Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

        # Applications
        Key([MOD], 'Return', lazy.spawn(TERMINAL),     desc="Launch terminal"),
        Key([MOD], 't',      lazy.spawn(TERMINAL),     desc="Launch terminal"),
        Key([MOD], 'b',      lazy.spawn(BROWSER),      desc="Launch browser"),
        Key([MOD], 'e',      lazy.spawn(FILE_MANAGER), desc="Launch file manager"),
        Key([MOD], 'c',      lazy.spawn(CODE_EDITOR),  desc="Launch code editor"),

        # Keyboard layout
        Key([MOD], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout"),

        # Print
        Key([], 'Print', lazy.spawn('bash -c "maim -f \'png\' -s ~/Pictures/Screenshots/$(date +%s).png"'), desc="Take a screenshot"),

        # Rofi
        Key([MOD], 'p', lazy.spawn('sh .config/rofi/bin/launcher_misc'), desc="Launch search"),
        Key([MOD], 'Escape', lazy.spawn('sh .config/rofi/bin/powermenu'), desc="Launch menu"),
        Key([MOD], 'a', lazy.spawn('bash -c "rofi -no-lazy-grab -theme \".config/rofi/themes/dt-dmenu.rasi\" -modi \"devilbox:$HOME/.config/rofi/scripts/devilbox-projects.sh\" -show devilbox"'), desc="Launch menu to choose project"),

        # Qtile
        Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([MOD], "w", lazy.window.kill(), desc="Kill focused window"),
        Key([MOD, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([MOD], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    ]
    keys.extend(set_group_keys(groups))
    return keys

def set_group_keys(groups):
    group_keys = []
    for i in groups:
        group_keys.extend(
            [
                # Switch to group
                Key(
                    [MOD],
                    i.name,
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                ),
                
                # Move window to group
                Key(
                    [MOD, "shift"],
                    i.name,
                    lazy.window.togroup(i.name),
                    desc="Switch to & move focused window to group {}".format(i.name),
                )
            ]
        )
    return group_keys
