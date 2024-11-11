if status is-interactive
    # Commands to run in interactive sessions can go here
end
# function _navi_smart_replace
#     set -l current_process (commandline -p | string trim)
#
#     if test -z "$current_process"
#         commandline -i (navi --print)
#     else
#         set -l best_match (navi --print --best-match --query "$current_process")
#
#         if not test "$best_match" >/dev/null
#             return
#         end
#
#         if test -z "$best_match"
#             commandline -p (navi --print --query "$current_process")
#         else if test "$current_process" != "$best_match"
#             commandline -p $best_match
#         else
#             commandline -p (navi --print --query "$current_process")
#         end
#     end
#
#     commandline -f repaint
# end

if test $fish_key_bindings = fish_default_key_bindings
    bind \cg _navi_smart_replace
else
    bind -M insert \cg _navi_smart_replace
end
navi widget fish | source
alias vpn="kill ssh ; sshpass -p arianahmadi421231 ssh -fNTD 0.0.0.0:8080 arian-p1@5.75.202.226"
alias v="nvim"
alias shd="sudo shutdown now"
alias msc="ncmpcpp"
alias dcker="sudo docker "
alias music="mpd && ncmpcpp"
alias ls="ls --color"
alias bt="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias t="tmux attach-session -t"
alias p="proxychains4 -f /etc/proxychains.conf -q"
alias unzipp="7za x -P"
alias rs="evcxr"
alias md="mdbook serve"
alias wasm="cargo generate --git https://github.com/rustwasm/wasm-pack-template"
alias kl="xset led 3"
alias ccc="cargo watch -q -c -x clippy"
alias view="zathura"
alias lk="xscreensaver-command -lock"
alias discord="discord --proxy-server=\"socks5://0.0.0.0:9999\""
export NODE_OPTIONS=--openssl-legacy-provider
export PATH="/home/arian/.cargo/bin:$PATH"
export PATH="/home/arian/go/bin:$PATH"
export PATH="/home/arian/.local/bin:$PATH"
export FLYCTL_INSTALL="/home/arian/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source

# Created by `pipx` on 2024-03-23 07:50:08
set PATH $PATH /home/arian/.local/bin

export PATH="$PATH:/home/arian/.cyfrin/bin"
