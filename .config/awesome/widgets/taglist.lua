local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local tag_states = {
    selected = {
        empty = {
            icon  = '',
            color = '#d7e7f5',
            font  = 'Font Awesome 6 Pro Regular 6'
        },
        occupied = {
            icon  = '',
            color = '#d7e7f5',
            font  = 'Font Awesome 6 Pro Solid 6'
        }
    },
    occupied = {
        icon  = '',
        color = '#777d96',
        font  = 'Font Awesome 6 Pro Solid 6'
    },
    empty = {
        icon  = '',
        color = '#444857',
        font  = 'Font Awesome 6 Pro Regular 6'
    }
}

-- local function get_current_state(tag)
--     -- local currentstate = t.selected and (#t:clients() > 0 and states.selected.occupied or states.selected.empty)
--     --         or #t:clients() > 0 and states.occupied or states.empty

--     -- if (tag.selected) then
--     --     return tag_states.selected
--     -- end
-- end

local function get_tags(t)
    local alltags = awful.screen.focused().tags

    local previous_tag = alltags[t.index == 1 and 1 or t.index - 1]
    local selected_tag = awful.screen.focused().selected_tag
    local tags_after_current_have_clients = false

    for i = t.index + 1, #alltags do
        if #alltags[i]:clients() > 0 then
            tags_after_current_have_clients = true
        end
    end

    return t.selected or -- Selected
           t.index == 1 or -- Main
           #t:clients() > 0 or -- Occupied
           (#t:clients() == 0 and (#previous_tag:clients() > 0 or selected_tag.index > t.index or tags_after_current_have_clients))
end



local get_taglist = function(s)
    -- Taglist buttons
    local taglist_buttons = gears.table.join(
        awful.button({}, 1,
            function(t) t:view_only() end),

        awful.button({ modkey }, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end

        end),

        awful.button({}, 3, awful.tag.viewtoggle),

        awful.button({ modkey }, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end),

        awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end),

        awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))

    local states = {
        selected = {
            empty = {
                icon  = '',
                color = '#d7e7f5',
                font  = 'Font Awesome 6 Pro Regular 6'
            },
            occupied = {
                icon  = '',
                color = '#d7e7f5',
                font  = 'Font Awesome 6 Pro Solid 6'
            }
        },
        occupied = {
            icon  = '',
            color = '#777d96',
            font  = 'Font Awesome 6 Pro Solid 6'
        },
        empty = {
            icon  = '',
            color = '#444857',
            font  = 'Font Awesome 6 Pro Regular 6'
        },
        urgent = {
            icon  = '',
            color = '#f27360',
            font  = 'Font Awesome 6 Pro Solid 6'
        },
    }

    local function is_urgent(tag)
        local tag_clients = tag:clients()
        for i = 1, #tag_clients do
            if tag_clients[i].urgent then
                return true
            end
        end
        return false
    end

    local function get_current_state(tag)
        if is_urgent(tag) then
            return states.urgent
        end

        return tag.selected and (#tag:clients() > 0 and states.selected.occupied or states.selected.empty)
            or #tag:clients() > 0 and states.occupied or states.empty
    end

    -- Function to update the tags
    local update_tags = function(self, t)
        local tagicon = self:get_children_by_id('icon_role')[1]

        local currentstate = get_current_state(t)

        tagicon.markup = string.format('<span font="%s" foreground="%s">%s</span>', currentstate.font, currentstate.color, currentstate.icon)
    end

    local function tags(t)
        local alltags = awful.screen.focused().tags

        local previous_tag = alltags[t.index == 1 and 1 or t.index - 1]
        local selected_tag = awful.screen.focused().selected_tag
        local tags_after_current_have_clients = false

        for i = t.index + 1, #alltags do
            if #alltags[i]:clients() > 0 then
                tags_after_current_have_clients = true
            end
        end

        return t.selected or -- Selected
               t.index == 1 or -- Main
               #t:clients() > 0 or -- Occupied
               (#t:clients() == 0 and (#previous_tag:clients() > 0 or selected_tag.index > t.index or tags_after_current_have_clients))
    end

    local icon_taglist = awful.widget.taglist {
        screen = s,
        filter = tags,
        buttons = taglist_buttons,
        layout = {
            spacing = 0,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    id = 'icon_role',
                    widget = wibox.widget.textbox
                },
                id = 'margin_role',
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(6),
                right = dpi(6),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = update_tags,
            update_callback = update_tags
        }
    }
    return icon_taglist
end

return get_taglist
