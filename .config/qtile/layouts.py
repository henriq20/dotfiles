from colors import colors
from libqtile import layout

layouts = [
    layout.MonadTall(border_focus=colors['foreground'],
                     border_normal='#444857',
                     border_width=1,
                     margin=5,
                     single_border_width=0,
                     single_margin=0,
                     new_client_position='bottom'
    ),
    layout.Max()
]
