from libqtile import widget, bar
from libqtile.config import Screen

from widgets.Icon import Icon as CustomIcon
from widgets.GroupBox import GroupBox as CustomGroupBox

from utils.bar import *

from colors import colors
from icons import HEADPHONES_ICON, MOON_ICON, UPDATES_ICON, ARCH_LINUX_ICON

primary_screen = Screen(
    top=bar.Bar(
        [
            widget.Spacer(length=15),

            # Shows the Arch Linux logo
            widget.Image(filename=ARCH_LINUX_ICON,
                         margin=7
            ),

            # Shows the groups (i.e workspaces)
            CustomGroupBox(font='Font Awesome 6 Pro Solid',
                           highlight_method='text',
                           this_current_screen_border=colors['accent'],
                           active=colors['foreground_dim'],
                           urgent_text=colors['urgent'],
                           urgent_alert_method='text',
                           fontsize=8,
                           margin_y=4
            ),

            widget.Prompt(fmt='<b>{}</b>',
                          markup=True,
                          foreground=colors['foreground'],
                          prompt=''),

            widget.Spacer(),

            # Shows an icon of an arrow pointed upwards, indicating whether it is time to update or not
            CustomIcon(text=UPDATES_ICON,
                       predicate=has_more_than_a_hundred_of_updates,
                       colors=['#D7E7F5', '#777D96'],
                       font='Font Awesome 6 Pro Solid',
                       update_interval=0
            ),

            # Shows an icon of a moon, indicating whether redshift is on or not
            CustomIcon(text=MOON_ICON,
                       predicate=is_redshift_on,
                       colors=['#D7E7F5', '#777D96'],
                       font='Font Awesome 6 Pro Solid'
            ),

            # Shows an icon of a headphone, indicating whether it is connected or not
            CustomIcon(text=HEADPHONES_ICON,
                       predicate=is_headphones_connected,
                       colors=['#D7E7F5', '#777D96'],
                       font='Font Awesome 6 Pro Solid'
            ),

            # Shows the current keyboard layout
            widget.KeyboardLayout(configured_keyboards=['us', 'us intl'],
                                  display_map={ 'us intl': 'USI' },
                                  font='JetBrains Mono',
                                  foreground='#777D96',
                                  fmt='<b>{}</b>',
                                  markup=True
            ),

            widget.Spacer(length=8),

            widget.Clock(format="<b>%a %d</b>",
                         markup=True,
                         foreground='#a9b1d6'
            ),

            widget.Clock(format="<b>%-I:%M %p</b>",
                         markup=True,
                         foreground='#a9b1d6'
            ),

            widget.Spacer(length=15)
        ],
        30,
        background=colors['background'] + '4d',
        margin=0
    ),
)
