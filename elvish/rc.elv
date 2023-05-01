# aliases
fn ls {|@a| e:exa --icons -a -l -F --group-directories-first $@a }
fn lst {|@a| e:exa --icons -T --group-directories-first $@a }
fn cat {|@a| e:bat $@a }
fn powlvl {|@a| e:bat /sys/class/power_supply/BAT0/capacity $@a }
fn volume {|@a| e:amixer get Master $@a }
fn volumeset {|@a| e:amixer set Master $@a }
fn shutdown {|@a| e:shutdown now $@a }
fn reboot {|@a| e:sudo reboot now $@a }
fn s1off {|@a| e:xrandr --output eDP-1 --off $@a }
fn s1on {|@a| e:xrandr --output eDP-1 --mode 1920x1080 $@a }
fn s2off {|@a| e:xrandr --output HDMI-1 --off $@a }
fn s2on {|@a| e:xrandr --output HDMI-1 --mode 1920x1080 $@a }
fn resPer {|@a| e:sudo chmod -R a+rwX $@a }
fn hx {|@a| e:helix $@a }
fn cl {|@a| e:clear $@a }
fn clearPac {|@a| e:sudo rm /var/lib/pacman/db.lck $@a }
fn s1brigth {|@a| e:xrandr --output eDP-1 --brightness $@a}
fn jo {|@a| e:joshuto $@a}

# starship prompt
eval (starship init elvish)
