#!/usr/bin/env bash

if [ "$#" -eq 1 ]; then
    code $HOME/devilbox/data/www/$1
else
    ls $HOME/devilbox/data/www/
fi

