import XMonad
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.MouseResize
import XMonad.Actions.FindEmptyWorkspace

-- Utils
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.ClickableWorkspaces
import XMonad.Util.WorkspaceCompare

-- Layouts
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing

-- Hooks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, shorten, wrap, PP(..))

-- Data
import Data.Map
import Data.Monoid (Endo)
import Data.Maybe (fromJust)
import qualified Data.Map as M

-- Colors
import Colors.TokyoNight

myFont :: String
myFont = "xft:JetBrainsMono NF:regular:size=14:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "microsoft-edge-stable"

myFileManager :: String
myFileManager = "pcmanfm"

myTextEditor :: String
myTextEditor = "emacsclient -c"

myCodeEditor :: String
myCodeEditor = "code"

myBorderWidth :: Dimension
myBorderWidth = 1

myNormalColor :: String
myNormalColor = "#444857"

myFocusColor :: String
myFocusColor = color06

myWorkspaces :: [String]
myWorkspaces = [" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "]

mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

myLayoutHook = smartBorders $ avoidStruts $ mouseResize $ mySpacing 5 $ layoutHook def

myStartupHook :: X ()
myStartupHook = do
    -- spawn "killall trayer"
    -- spawn ("sleep 2; trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 " ++ colorTrayer ++ " --height 24")
    spawnOnce "numlockx on &"
    spawnOnce "lxsession &"
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom --experimental-backends &"
    spawnOnce "/usr/bin/emacs --daemon &"
    spawnOnce "redshift &"
    spawnOnce "dunst &"
    spawnOnce "setxkbmap -layout \"us,us\" -variant \",intl\" -option \"grp:alt_shift_toggle\""


myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
    [
        className =? "Qalculate-gtk" --> doFloat,
        isDialog                     --> doF W.swapUp,
        -- className =? "spotify" --> shiftTo Next EmptyWS 1,
        manageDocks,
        insertPosition End Newer,
        manageHook def
    ]

myHandleEventHook = swallowEventHook (className =? "Alacritty") (return True)

myKeys :: [(String, X ())]
myKeys =
    [
        -- Xmonad
        ("M-S-r", spawn "xmonad --recompile; xmonad --restart"),

        -- Print
        ("<Print>", spawn "scrot -s ~/Pictures/Screenshots"),

        -- Rofi
        ("M-p", spawn "rofi -show run"),
        ("M-<Esc>", spawn "cd $HOME/.config/rofi/bin; ./powermenu"),
        ("M-a", spawn "rofi -no-lazy-grab -theme \"$HOME/.config/rofi/themes/dt-dmenu.rasi\" -modi \"devilbox:$HOME/.config/rofi/scripts/devilbox-projects.sh\" -show devilbox"),

        -- Applications
        ("M-<Return>", spawn myTerminal),
        ("M-t", spawn myTerminal),
        ("M-b", spawn myBrowser),
        ("M-e", spawn myFileManager),
        ("M-c", spawn myCodeEditor),
        ("M-d", spawn myTextEditor),

        -- Kill
        ("M-q", kill1)
    ]

myMouseBindings =
    [
        -- Workspaces
        ((myModMask, button5), const nextWS),
        ((myModMask, button4), const prevWS)
    ]

main :: IO ()
main = do
    -- Launches xmobar
    myXMobar <- spawnPipe "xmobar $HOME/.config/xmobar/xmobar.hs"
    
    xmonad $ docks $ ewmhFullscreen $ def {
        terminal           = myTerminal,
        modMask            = myModMask,
        borderWidth        = myBorderWidth,
        normalBorderColor  = myNormalColor,
        manageHook         = myManageHook,
        handleEventHook    = myHandleEventHook,
        focusedBorderColor = myFocusColor,
        startupHook        = myStartupHook,
        layoutHook         = myLayoutHook,
        workspaces         = myWorkspaces,
        focusFollowsMouse  = False,
        clickJustFocuses   = False,
        logHook            = dynamicLogWithPP $ xmobarPP {
            -- Opens XMobar
            ppOutput = hPutStrLn myXMobar,

            -- Current workspace
            ppCurrent = xmobarColor color06 "" . wrap
                ("<box type=Bottom width=2 color=" ++ color06 ++ ">") "</box>",

            -- Sets the title of the active window to blank
            ppTitle = const "",

            -- Sets the current layout name to blank
            ppLayout = const "",

            -- Sets the separator between the workspaces and arch logo to a `|` character
            ppSep = "<fc=" ++ color09 ++ "><fn=1>|</fn></fc>"
        }
    } `additionalKeysP` myKeys `additionalMouseBindings` myMouseBindings
