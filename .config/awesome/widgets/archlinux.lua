local wibox = require('wibox')

return wibox.widget {
    image         = '/home/henriq/.config/awesome/arch-linux.png',
    resize        = true,
    forced_width  = 18,
    forced_height = 18,
    widget        = wibox.widget.imagebox
}
