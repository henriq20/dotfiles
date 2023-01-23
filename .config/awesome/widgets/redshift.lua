local awful = require('awful')

return awful.widget.watch('bash -c "redshift -p | awk \'/Period/ {print $2}\'"', 60,
    function(widget, stdout)
        if stdout ~= 'Night\n' then
            widget:set_font('Font Awesome 6 Pro Solid 8')
            widget:set_markup('<span foreground="#777D96"></span>')
        else
            widget:set_font('Font Awesome 6 Pro Solid 8')
            widget:set_markup('<span foreground="#D7E7F5"></span>')
        end
    end
)
