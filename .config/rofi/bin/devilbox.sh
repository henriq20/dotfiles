#!/usr/bin/env bash

rofiDir="$HOME/.config/rofi"

if [ "$#" -eq 1 ]; then
    code $HOME/devilbox/data/www/$1
else
    ls $HOME/devilbox/data/www/
fi

$rofiCommand = "rofi -no-lazy-grab -theme $rofiDir/"themes/dt-dmenu.rasi" -modi "devilbox: $rofiDir/scripts/devilbox-projects.sh" -show devilbox"

chosen="$(echo $rofiCommand)"
