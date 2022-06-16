-- Check Plank

Config {
    additionalFonts = [
        "xft:Font Awesome 6 Pro Solid:pixelsize=13",
        "xft:Font Awesome 6 Pro Regular:pixelsize=13",
        "xft:Font Awesome 6 Pro Light:pixelsize=13",
        "xft:JetBrainsMono NF:weight=bold:size=4:antialias=true:hinting=true"
    ],
    font            = "xft:JetBrainsMono NF:weight=bold:size=9:antialias=true:hinting=true",
    textOffsets     = [ 20, 20, 20 ],
    bgColor         = "#1a1b26",
    fgColor         = "#a9b1d6",
    alpha           = 100,
    position        = TopSize L 100 30,
    textOffset      = 20,
    iconOffset      = 14,
    lowerOnStart    = True,
    hideOnStart     = False,
    allDesktops     = True,
    persistent      = True,
    sepChar         = "%",
    alignSep        = "}{",
    iconRoot        = ".config/xmobar/icons/",
    commands        = [
        -- Disk space free
        Run DiskU [("/", "<free>")] [] 60,

        -- Keyboard Layout
        Run Kbd [("us", "US"), ("us(intl)", "USI")],
        
        -- Time
        Run Date "%-I:%M %p" "time" 10,

        -- Date
        Run Date "<fc=#a9b1d6>%a %d</fc>" "date"  100000,

        -- Checks for pacman updates only one time
        Run Com ".config/xmobar/scripts/pacupdate" [] "pacupdate" 0,

        -- Echoes a 'disk' icon
        Run Com "echo" ["<fn=1>\xf0c7</fn>"] "diskIcon" 0,

        -- Echoes an 'arrow' icon
        Run Com "echo" ["<fn=1>\xf0aa</fn>"] "upIcon" 0,

        -- Echoes a 'arrow' icon pointed down
        Run Com "echo" ["<fn=1>\xf13a</fn>"] "downIcon" 0,

        -- Echoes a '<' icon
        Run Com "echo" ["<fc=#4E5173><fn=1>\xf053</fn></fc>"] "sepIcon" 0,

        -- Echoes a 'keyboard' icon
        Run Com "echo" ["<fn=2>\xf11c</fn>"] "keyboardIcon" 0,

        -- Echoes a 'bluetooth' icon
        Run Com "echo" ["<fn=2>\xf293</fn>"] "bluetoothIcon" 0,

        -- Echoes a '|'
        Run Com "echo" ["<fc=#4E5173>|</fc>"] "barIcon" 0,

        -- Echoes a 'moon' icon
        Run Com "echo" ["<fn=1>\xf186</fn>"] "moonIcon" 0,

        -- Echoes a 'magnifying glass' icon
        Run Com "echo" ["<fn=2>\xf002</fn>"] "zoomIcon" 0,

        -- Echoes a 'clock' icon
        Run Com "echo" ["<fn=1>\xf017</fn>"] "clockIcon" 0,

        -- Prints out the left side items such as workspaces, layout, etc.
        Run UnsafeStdinReader
    ],
    template = "  \
        \ <action=`cd $HOME/.config/rofi/bin; ./powermenu`><icon=arch_logo_16x16.xpm/></action>  %UnsafeStdinReader% }{\
        \ <fc=#bb9af7><action=`alacritty -e htop`>%diskIcon% %disku%</action></fc>  \
        \ <fc=#ff9e64><action=`alacritty -e sudo pacman -Syu`>%upIcon% %pacupdate%</action></fc>  \
        \ %keyboardIcon% %kbd%  \
        \ %date%<fn=4> </fn>\
        \ <fc=#a9b1d6>%time%</fc>   \
    \"
    -- template = " \
    --     \ <action=`cd $HOME/.config/rofi/bin; ./powermenu`><icon=arch_logo_16x16.xpm/></action> %barIcon% %UnsafeStdinReader% }{\
    --     \ %keyboardIcon% %kbd% %sepIcon%\
    --     \ <fc=#bb9af7><action=`alacritty -e htop`>%diskIcon% %disku%</action></fc> %sepIcon%\
    --     \ <fc=#ff9e64><action=`alacritty -e sudo pacman -Syu`>%upIcon% %pacupdate%</action></fc> %sepIcon%\
    --     \ %date% %sepIcon%\
    --     \ <fc=#7dcfff>%clockIcon% %time%</fc>  \
    -- \"
}
