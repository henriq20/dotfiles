pcall(require, 'luarocks.loader')

local gears     = require('gears')
local awful     = require('awful')
local wibox     = require('wibox')
local naughty   = require('naughty')
local beautiful = require('themes.init')
local widgets   = require('widgets.init')
local globals   = require('globals')

require('awful.autofocus')

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = tostring(err) })
        in_error = false
    end)
end

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.max,
}

-- Toggle volume: amixer -D pulse set Master 1+ toggle

awful.screen.connect_for_each_screen(
    function(s)
        awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])

        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt({
            prompt = ''
        })

        -- mytaglist = mytaglist(s)
        widgets.taglist = widgets.taglist(s)
        s.mytaglist = widgets.taglist

        s.mywibox = awful.wibar({
            position = 'top',
            screen   = s,
            height   = 30,
            bg       = '#1a1b264d',
            fg       = '#a9b1d6'
        })

        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            {
                -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.container.margin(widgets.archlinux, 15, 8, 6),
                wibox.container.margin(s.mytaglist      , 0 , 0, 0),
                s.mypromptbox
            },
            {
                -- Middle widgets
                layout = wibox.layout.fixed.horizontal
            },
            {
                -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.container.margin(widgets.keyboard  , 0 , 10 , 0, 0),
                wibox.container.margin(widgets.volume    , 0 , 10 , 0, 0),
                wibox.container.margin(widgets.internet  , 0 , 10 , 0, 0),
                wibox.container.margin(widgets.redshift  , 0 , 10 , 0, 0),
                wibox.container.margin(widgets.headphones, 0 , 10 , 0, 0),
                wibox.container.margin(widgets.time.date , 10, 10 , 0, 0),
                wibox.container.margin(widgets.time.clock, 0 , 15, 0, 0)
            },
        }
    end
)

-- Mouse bindings
root.buttons(gears.table.join(
    -- Go to the previous tag when scroll up
    awful.button({ globals.modkey }, 4, awful.tag.viewprev),
    -- Go to the next tag when scroll down
    awful.button({ globals.modkey }, 5, awful.tag.viewnext)
))

-- Key bindings
local globalkeys = gears.table.join(
    -- Go to the previous tag
    awful.key({ globals.modkey }, 'Left', awful.tag.viewprev, {
        description = 'view previous',
        group = 'tag'
    }),

    -- Go to the next tag
    awful.key({ globals.modkey, }, 'Right', awful.tag.viewnext, {
        description = 'view next',
        group = 'tag'
    }),

    -- Focus next client
    awful.key({ globals.modkey, }, 'j', function() awful.client.focus.byidx(1) end, {
        description = 'focus next by index',
        group = 'client'
    }),

    -- Focus previous client
    awful.key({ globals.modkey, }, 'k', function() awful.client.focus.byidx(-1) end, {
        description = 'focus previous by index',
        group = 'client'
    }),

    -- Swap with next client
    awful.key({ globals.modkey, 'Shift' }, 'j', function() awful.client.swap.byidx(1) end, {
        description = 'swap with next client by index',
        group = 'client'
    }),

    -- Swap with previous client
    awful.key({ globals.modkey, 'Shift' }, 'k', function() awful.client.swap.byidx(-1) end, {
        description = 'swap with previous client by index',
        group = 'client'
    }),

    -- Go to urgent client
    awful.key({ globals.modkey, }, 'u', awful.client.urgent.jumpto, {
        description = 'jump to urgent client',
        group = 'client'
    }),

    -- Focus previous focused client
    awful.key({ globals.modkey, }, 'Tab', function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = 'go back',
        group = 'client'
    }),

    -- Toggle volume
    awful.key({ globals.modkey, }, 'Print', function() awful.spawn('amixer -D pulse set Master 1+ toggle') end, {
        description = 'toggle the volume',
        group = 'client'
    }),

    -- Open terminal
    awful.key({ globals.modkey, }, 'Return', function() awful.spawn(globals.terminal) end, {
        description = 'open a terminal',
        group = 'launcher'
    }),

    -- Reload awesome
    awful.key({ globals.modkey, 'Control' }, 'r', awesome.restart, {
        description = 'reload awesome',
        group = 'awesome'
    }),

    -- Quiet awesome
    awful.key({ globals.modkey, 'Shift' }, 'q', awesome.quit, {
        description = 'quit awesome',
        group = 'awesome'
    }),

    -- Increase master client width
    awful.key({ globals.modkey, }, 'l', function() awful.tag.incmwfact(0.05) end, {
        description = 'increase master width factor',
        group = 'layout'
    }),

    -- Decrease master client width
    awful.key({ globals.modkey, }, 'h', function() awful.tag.incmwfact(-0.05) end, {
        description = 'decrease master width factor',
        group = 'layout'
    }),

    -- Go to the next layout
    awful.key({ globals.modkey, }, 'space', function() awful.layout.inc(1) end, {
        description = 'select next',
        group = 'layout'
    }),

    -- Go to the previous layout
    awful.key({ globals.modkey, 'Shift' }, 'space', function() awful.layout.inc(-1) end, {
        description = 'select previous',
        group = 'layout'
    }),

    -- Prompt
    awful.key({ globals.modkey }, 'r', function() awful.screen.focused().mypromptbox:run() end, {
        description = 'run prompt',
        group = 'launcher'
    }),

    -- Rofi (applications)
    awful.key({ globals.modkey }, 'p', function()
        awful.spawn({ 'sh', '.config/rofi/bin/launcher_misc' })
        end, {
        description = 'run applications',
        group = 'launcher'
    }),

    -- Go to the previous selected tag
    awful.key({ globals.modkey, }, 'Escape', function () awful.spawn({ 'sh', '.config/rofi/bin/powermenu' }) end, {
        description = 'launch power menu',
        group = 'launcher'
    }),

    -- Take screenshot
    awful.key({}, 'Print', function() awful.spawn({ 'bash', '-c', 'maim -f \'png\' -s ~/Pictures/Screenshots/$(date +%s).png' }) end, {
        description = 'take screenshot',
        group = 'launcher'
    }),

    -- Launch file manager
    awful.key({ globals.modkey }, 'e', function() awful.spawn(globals.file_manager) end, {
        description = 'launch file manager',
        group = 'launcher'
    }),

    -- Launch code editor
    awful.key({ globals.modkey }, 'c', function() awful.spawn(globals.code_editor) end, {
        description = 'launch code editor',
        group = 'launcher'
    }),

    -- Launch browser
    awful.key({ globals.modkey }, 'b', function() awful.spawn(globals.browser) end, {
        description = 'launch browser',
        group = 'launcher'
    }),

    -- Rofi (devilbox projects)
    awful.key({ globals.modkey }, 'a', function()
        -- Toggle taglist visibility
        widgets.taglist:set_visible(not widgets.taglist:get_visible())
        local cmd = 'rofi -no-lazy-grab -theme "~/.config/rofi/themes/dt-dmenu.rasi" -modi "devilbox:~/.config/rofi/scripts/devilbox-projects.sh" -show devilbox'
        awful.spawn.easy_async_with_shell(cmd, function ()
            widgets.taglist:set_visible(not widgets.taglist:get_visible())
        end)
    end, {
        description = 'show devilbox projects',
        group = 'launcher'
    })
)

local clientkeys = gears.table.join(
    -- Toggle fullscreen
    awful.key({ globals.modkey, }, 'f', function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {
        description = 'toggle fullscreen',
        group = 'client'
    }),

    -- Close client
    awful.key({ globals.modkey, 'Shift' }, 'c', function(c) c:kill() end, {
        description = 'close',
        group = 'client'
    }),

    -- Move focused client to master
    awful.key({ globals.modkey, 'Control' }, 'Return', function(c) c:swap(awful.client.getmaster()) end, {
        description = 'move to master',
        group = 'client'
    }),

    awful.key({ globals.modkey }, 'm',
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end, {
        description = 'maximize',
        group = 'client'
    }),

    -- Move focused client to next tag
    awful.key({ globals.modkey, 'Shift' }, 'Right',
        function(c)
            local s = awful.screen.focused()
            c:move_to_tag(s.tags[s.selected_tag.index + 1] or s.tags[1])
            awful.tag.viewnext(1)
        end, {
        description = 'move to next tag',
        group = 'client'
    }),

    -- Move focused client to previous tag
    awful.key({ globals.modkey, 'Shift' }, 'Left',
        function(c)
            local s = awful.screen.focused()
            c:move_to_tag(s.tags[s.selected_tag.index - 1] or s.tags[9])
            awful.tag.viewprev(1)
        end, {
        description = 'move to previous tag',
        group = 'client'
    })
)

-- Bind all key numbers to tags.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag
        awful.key({ globals.modkey }, '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end, {
            description = 'view tag #' .. i,
            group = 'tag'
        }),

        -- Toggle tag view
        awful.key({ globals.modkey, 'Control' }, '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end, {
            description = 'toggle tag #' .. i,
            group = 'tag'
        }),

        -- Move client to tag
        awful.key({ globals.modkey, 'Shift' }, '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end, {
            description = 'move focused client to tag #' .. i,
            group = 'tag'
        })
    )
end

local clientbuttons = gears.table.join(
    -- Go to previous tag
    awful.button({ globals.modkey }, 4, function ()
        awful.tag.viewprev(1)
    end),

    -- Go to next tag
    awful.button({ globals.modkey }, 5, function ()
        awful.tag.viewnext(1)
    end),

    -- Toggle floating
    awful.button({ globals.modkey }, 2, awful.client.floating.toggle),

    -- Click
    awful.button({}, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
    end),

    -- Move client
    awful.button({ globals.modkey }, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.move(c)
    end),

    -- Resize client
    awful.button({ globals.modkey }, 3, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the 'manage' signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus        = awful.client.focus.filter,
            raise        = true,
            keys         = clientkeys,
            buttons      = clientbuttons,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA', -- Firefox addon DownThemAll.
                'copyq', -- Includes session name in class.
                'pinentry',
            },
            class = {
                'Arandr',
                'Blueman-manager',
                'Gpick',
                'Galculator',
                'Kruler',
                'MessageWin', -- kalarm.
                'Sxiv',
                'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
                'Wpa_gui',
                'veromix',
                'xtightvncviewer'
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                'Event Tester', -- xev.
                'Preferences',
            },
            role = {
                'AlarmWindow', -- Thunderbird's calendar.
                'ConfigManager', -- Thunderbird's about:config.
                'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            floating  = true,
            placement = awful.placement.centered + awful.placement.no_overlap
        }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {
                'normal',
                'dialog'
            }
        },
        properties = {
            titlebars_enabled = false
        }
    },

    -- {
    --     rule = {
    --         class = '[Ss]potify'
    --     },
    --     properties = {
    --         screen = 1,
    --         tag    = '5'
    --     }
    -- },
}

----------------------------------------------------------------------------------------
-- Signals
----------------------------------------------------------------------------------------

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Remove borders if single window
screen.connect_signal('arrange', function(s)
    local is_max_layout = s.selected_tag.layout.name == 'max'
    local only_one_client = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
    -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
    for _, c in pairs(s.clients) do
        if (is_max_layout or only_one_client) and not c.floating or c.maximized then
            c.border_width = 0
            return
        else
            c.border_width = beautiful.border_width
        end
    end
end)

local function file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    end

    return false
end

-- Prevent steam games from disappearing when minimized
client.connect_signal('property::minimized', function(c)
    c.minimized = false
end)

client.connect_signal('focus', function(c)
    c.border_color = beautiful.border_focus
end)

client.connect_signal('unfocus', function (c)
    c.border_color = beautiful.border_normal
end)

awesome.connect_signal('startup', function ()
    if not file_exists('/tmp/awesome_tags') then
        return
    end

    local tmp_file = assert(io.open('/tmp/awesome_tags', 'r'))

    io.input(tmp_file)
    awful.screen.focused().tags[tonumber(io.read())]:view_only()
    io.close(tmp_file)
end)

awesome.connect_signal('exit', function (reason_restart)
    if not reason_restart then
        return
    end

    local tmp_file = assert(io.open('/tmp/awesome_tags', 'w'))

    io.output(tmp_file)
    io.write(awful.screen.focused().selected_tag.index or 1)
    io.close(tmp_file)
end)

tag.connect_signal('property::selected', function(current_tag)
    if not current_tag.selected then
        return
    end

    local tags = awful.screen.focused().tags

    for i = 1, #tags do
        local t = tags[i]

        if #t:clients() == 0 and t.index ~= current_tag.index then
            for j = t.index + 1, #tags do
                local next_tag = tags[j]

                if #next_tag:clients() > 0 and next_tag.index ~= current_tag.index then
                    for c = 1, #next_tag:clients() do
                        next_tag:clients()[c]:move_to_tag(t)
                    end

                    break
                end
            end

            break
        end
    end
end)
