# Qtile
from libqtile import layout
from libqtile.config import Match

# Groups
from groups import groups

# Screens
from screens.primary import primary_screen

# Layouts
from layouts import layouts

# Hooks
from hooks import setgroup

# Key and Mouse Bindings
from bindings.keys import get as get_keys
from bindings.mouse import get as get_mouse

# Colors
from colors import colors

keys = get_keys(groups)

widget_defaults = dict(
    font="JetBrains Mono",
    fontsize=12
)
extension_defaults = widget_defaults.copy()

screens = [
    primary_screen
]

mouse = get_mouse(groups)

# Hooks
setgroup.setup()

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=colors['foreground'],
    border_normal='#444857',
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="galculator"),  # Calculator
        Match(title='Preferences'), # Anki
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True

# Setting this property to `focus` instead of `smart` prevents sub-windows appearing behind their parent.
focus_on_window_activation = "focus"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
