#alias
alias ls="exa --icons -a -l -F --group-directories-first"
alias lst="exa --icons -T --group-directories-first"
alias cat="bat"
alias powlvl="bat /sys/class/power_supply/BAT0/capacity"
alias volume="amixer get Master"
alias volumeset="amixer set Master"
alias shutdown="shutdown now"
alias reboot="sudo reboot now"
alias s1off="xrandr --output eDP-1 --off"
alias s1on="xrandr --output eDP-1 --mode 1920x1080"
alias s2off="xrandr --output HDMI-1 --off"
alias s2on="xrandr --output HDMI-1 --mode 1920x1080"
alias resPer="sudo chmod -R a+rwX"
alias cl="clear"
alias clearPac="sudo rm /var/lib/pacman/db.lck"
alias s1brigth="xrandr --output eDP-1 --brightness"
alias jo="joshuto"
alias hx="helix"

#function
function cd {
    builtin cd $1 && ls -F
    }

function mkdircd {
    command mkdir $1 && cd $_
}

#starship prompt
eval "$(starship init bash)"