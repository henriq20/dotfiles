local awful = require('awful')

return awful.widget.watch('bash -c "amixer get Master | tail -2 | grep -c \'\\[on\\]\'"', 1,
    function(widget, stdout)
        if stdout == '2\n' then
            widget:set_font('Font Awesome 6 Pro Solid 8')
            widget:set_markup('<span foreground="#D7E7F5"></span>')
        else
            widget:set_font('Font Awesome 6 Pro Solid 8')
            widget:set_markup('<span foreground="#777D96"></span>')
        end
    end
)
