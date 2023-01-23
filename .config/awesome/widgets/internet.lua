local awful = require('awful')

return awful.widget.watch('bash -c "ping -c 1 8.8.8.8"', 30,
    function(widget, _, _, _, code)
        if code == 0 then
            widget:set_font('Material Icons Round 9')
            widget:set_markup('<span foreground="#D7E7F5"></span>')
        else
            widget:set_font('Material Icons Round 9')
            widget:set_markup('<span foreground="#777D96"></span>')
        end
    end
)
