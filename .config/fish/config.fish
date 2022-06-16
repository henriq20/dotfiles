if status is-interactive
    # Commands to run in interactive sessions can go here
end

function dbc
    git clone $argv[1] ~/devilbox/data/www/$argv[2]
end

# Anki
alias anki="anki --no-sandbox"
alias ankiadd="echo $argv[1] >> ~/.anki/words.txt"
alias ankiopen="vim ~/.anki/words.txt"

# MySQL
alias sql="mysql -u root -p"

# Systemctl
alias sstart="sudo systemctl start"
alias sstop="sudo systemctl stop"

# Ls
alias ls="logo-ls"

# Git


# Devilbox
alias db="docker exec --user devilbox -it devilbox-php-1 bash"
alias dbup="sstop mariadb && cd ~/devilbox && ./start.sh; cd -"
alias dbdown="cd ~/devilbox && ./stop.sh && sstart mariadb; cd -"
alias proj="code /home/henriq/devilbox/data/www/*$argv[1]*"

# Fish Config
alias fishconf="vim ~/.config/fish/config.fish"

# Pacman
alias pacs="sudo pacman -S"
alias pacr="sudo pacman -R"
alias pac-prune="sudo pacman -R (pacman -Qdt | awk '{print $1}')"

# Others
alias cp="cp -r"
alias rmp3="rm ~/.anki/audios/*.mp3"
alias cat="bat"

# Shutdown
alias shutdown="sudo shutdown now"

# Mounting
alias arch="sudo mkdir -p /run/media/henriq/Arch && sudo mount /dev/nvme0n1p3 /run/media/henriq/Arch"

# Doom Emacs
alias doom-sync="cd ~/.emacs.d/bin; ./doom sync"
alias doom-reload="cd ~/.emacs.d/bin; ./doom reload"
alias emacs="emacsclient -c"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/henriq/.ghcup/bin # ghcup-env
