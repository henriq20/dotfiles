#!/usr/bin/env bash

# qtile cmd-obj -o widget groupbox -f eval -a "self.toggle_hide()" &>/dev/null & await

if [ "$#" -eq 1 ]; then 
    code ~/devilbox/data/www/$1
else
    ls ~/devilbox/data/www/
fi
