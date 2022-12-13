# aliases
fn ls {|@a| e:exa --icons -a -l -F --group-directories-first $@a }
fn lst {|@a| e:exa --icons -T --group-directories-first $@a }
fn cat {|@a| e:bat $@a }
fn powlvl {|@a| e:bat /sys/class/power_supply/BAT0/capacity $@a }
fn volume {|@a| e:amixer get Master $@a }
fn volumeset {|@a| e:amixer set Master $@a }
fn shutdown {|@a| e:shutdown now $@a }
fn reboot {|@a| e:sudo reboot now $@a }
fn screen1off {|@a| e:xrandr --output eDP-1 --off $@a }
fn screen1on {|@a| e:xrandr --output eDP-1 --mode 1920x1080 $@a }
fn screen2off {|@a| e: xrandr --output HDMI-1 --off $@a }
fn screen2on {|@a| e:xrandr --output HDMI-1 --mode 1920x1080 $@a }
fn resPer {|@a| e: sudo chmod -R a+rwX $@a }

# starship prompt
eval (starship init elvish)
