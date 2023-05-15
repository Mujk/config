if status is-interactive

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
    alias hx="helix"
    alias jo="joshuto"
    alias cl="clear"
    alias ~="~/DATA"
        
    #function
    function cd --argument dir # ls after cd
        if [ "dir" = "" ]
            builtin cd $HOME
        else
            builtin cd $dir
        end
        exa --icons -F --group-directories-first
    end

    function mkdircd
        command mkdir $argv
        builtin cd $argv
    end
end

#starship prompt
starship init fish | source