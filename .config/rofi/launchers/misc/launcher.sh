#!/usr/bin/env bash

theme="blurry"
dir="$HOME/.config/rofi/launchers/misc"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
