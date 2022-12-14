#alias
alias ls="exa --icons -a -l -F --group-directories-first"
alias lst="exa --icons -T --group-directories-first"
alias cat="bat"
alias powlvl="bat /sys/class/power_supply/BAT0/capacity"
alias volume="amixer get Master"
alias volumeset="amixer set Master"
alias shutdown="shutdown now"
alias reboot="sudo reboot now"
alias screen1off="xrandr --output eDP-1 --off"
alias screen1on="xrandr --output eDP-1 --mode 1920x1080"
alias screen2off="xrandr --output HDMI-1 --off"
alias screen2on="xrandr --output HDMI-1 --mode 1920x1080"
alias resPer="sudo chmod -R a+rwX"

#function
function cd {
    builtin cd "$@" && ls -F
    }

#starship prompt
eval "$(starship init bash)"