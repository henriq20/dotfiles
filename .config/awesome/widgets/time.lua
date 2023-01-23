local wibox     = require('wibox')

return {
    date  = wibox.widget.textclock('%a %d', 99999),
    clock = wibox.widget.textclock('%-I:%M %p')
}
