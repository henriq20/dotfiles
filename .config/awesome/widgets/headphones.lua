local awful = require('awful')

return awful.widget.watch('bash -c "bluetoothctl info 14:3F:A6:A7:EC:A9 | awk \'/Connected/ {print $2}\'"', 1,
    function(widget, stdout)
        if stdout == 'yes\n' then
            widget:set_font('Font Awesome 6 Pro Solid 8')
            widget:set_markup('<span foreground="#D7E7F5"></span>')
        else
            widget:set_font('Font Awesome 6 Pro Solid 8')
            widget:set_markup('<span foreground="#777D96"></span>')
        end
    end
)
