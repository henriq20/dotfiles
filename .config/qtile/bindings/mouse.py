from libqtile.lazy import lazy
from libqtile.config import Click, Drag

from personal import MOD

def get(groups):
    bindings = [
        # Set window to floating mode
        Drag([MOD], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),

        # Resize the window
        Drag([MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),

        # Toggle the floating mode
        Click([MOD], "Button2", lazy.window.toggle_floating()),  
    ]
    return bindings
