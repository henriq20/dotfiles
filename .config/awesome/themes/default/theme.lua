local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

return {
    font              = 'Inter SemiBold 8.5',

    bg_normal         = '#222222',
    bg_focus          = '#535d6c',
    bg_urgent         = '',
    bg_minimize       = '#444444',
    bg_systray        = '',

    fg_normal         = '#aaaaaa',
    fg_focus          = '#ffffff',
    fg_urgent         = '#f27360',
    fg_minimize       = '#ffffff',

    border_width      = dpi(1),
    border_normal     = '#444857',
    border_focus      = '#a9b1d6',
    border_marked     = '#a9b1d6',

    useless_gap       = dpi(3),
    gap_single_client = false,

    taglist_bg_focus  = '',

    menu_height       = dpi(15),
    menu_width        = dpi(100),

    icon_theme        = nil
}
