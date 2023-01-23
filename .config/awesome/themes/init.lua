local globals = require('globals')
local beautiful = require('beautiful')

local theme_path = string.format('%s/.config/awesome/themes/%s/theme.lua', os.getenv('HOME'), globals.theme_name)
beautiful.init(theme_path)

return beautiful
