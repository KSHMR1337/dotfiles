#!/bin/zsh

THEME_FILE="$HOME/.config/current_theme"
THEME_BASE_DIR="$HOME/.local/share/themes"
DWM_THEME=$(cat "$THEME_FILE" 2>/dev/null || echo "ultraviolence")

declare -A CONFIG_MAPPING=(
    [".backgrounds"]="backgrounds"
    [".config/dunst/dunstrc"]="dunst"
    [".config/gtk-3.0/settings.ini"]="gtk3"
    [".config/gtk-4.0/settings.ini"]="gtk4"
    [".config/nvim/lua/config/theme.lua"]="nvim.lua"
    [".config/nvim/lua/plugins/lualine-nvim.lua"]="lualine-nvim.lua"
    [".config/yazi/theme.toml"]="yazi.toml"
    [".dircolors"]="dircolors"
    [".gtkrc-2.0"]="gtk2"
    [".face.icon"]="faceicon.png"
    [".lockscreen"]="lockscreen"
    [".splash"]="splash"
    [".Xresources"]="Xresources"
    [".xsettingsd"]="xsettingsd"
    [".zcolors"]="zcolors"
)

declare -A SYSTEM_CONFIG_MAPPING=(
    ["/etc/sddm.conf.d/10-theme.conf"]="sddm_theme.conf"
    ["/etc/plymouth/plymouthd.conf"]="plymouthd.conf"
    ["/etc/gtk-2.0/gtkrc"]="gtk2"
    ["/etc/gtk-3.0/settings.ini"]="gtk3"
)

mkdir -p "$THEME_BASE_DIR"

get_grub_dir() {
    if [[ -x "$(command -v grub2-mkconfig)" && -d "/boot/grub2" ]]; then
        if [[ -x "$(command -v grub-mkconfig)" && -d "/boot/grub" ]]; then
            echo "ERROR: Both Grub2 and Grub detected"
            return 1
        else
            echo "/boot/grub2"
        fi
    elif [[ -x "$(command -v grub-mkconfig)" && -d "/boot/grub" ]]; then
        echo "/boot/grub"
    else
        echo "ERROR: No grub directory found"
        return 1
    fi
}

get_available_themes() {
    local themes=()
    if [[ -d "$THEME_BASE_DIR" ]]; then
        for theme_dir in "$THEME_BASE_DIR"/*(/N); do
            themes+=($(basename "$theme_dir"))
        done
    fi
    echo "${themes[@]}"
}

get_next_theme() {
    local current="$1"
    local themes=($(get_available_themes))
    
    if [[ ${#themes[@]} -eq 0 ]]; then
        echo "ultraviolence"
        return
    fi
    
    for i in {1..${#themes[@]}}; do
        if [[ "${themes[$i]}" == "$current" ]]; then
            local next_index=$(( (i % ${#themes[@]}) + 1 ))
            echo "${themes[$next_index]}"
            return
        fi
    done
    
    echo "${themes[1]}"
}

flip_symlink() {
    local symlink_path="$1"
    local new_target="$2"

    if [[ ! -f "$new_target" ]]; then
        echo "Warning: Theme file $new_target does not exist, skipping"
        return 1
    fi

    local symlink_dir=$(dirname "$symlink_path")
    mkdir -p "$symlink_dir"

    rm -rf "$symlink_path"
    ln -s "$new_target" "$symlink_path" && echo "Flipped $(basename "$symlink_path")"
}

flip_all_configs() {
    local theme_name="$1"
    local theme_dir="$THEME_BASE_DIR/$theme_name"

    if [[ ! -d "$theme_dir" ]]; then
        echo "Error: Theme directory $theme_dir does not exist"
        return 1
    fi

    for dotfile_path clean_name in ${(kv)CONFIG_MAPPING}; do
        local theme_config="$theme_dir/$clean_name"
        local target_path="$HOME/$dotfile_path"

        if [[ -f "$theme_config" ]]; then
            flip_symlink "$target_path" "$theme_config"
        else
            echo "  - Skipping $dotfile_path (not found in theme as $clean_name)"
        fi
    done
}

flip_system_configs() {
    local theme_name="$1"
    local theme_dir="$THEME_BASE_DIR/$theme_name"

    if [[ ! -d "$theme_dir" ]]; then
        echo "Error: Theme directory $theme_dir does not exist"
        return 1
    fi

    for system_path clean_name in ${(kv)SYSTEM_CONFIG_MAPPING}; do
        local theme_config="$theme_dir/$clean_name"

        if [[ -f "$theme_config" ]]; then
            local system_dir=$(dirname "$system_path")
            sudo mkdir -p "$system_dir"
            sudo rm -rf "$system_path"
            sudo ln -s "$theme_config" "$system_path" && echo "System: Flipped $(basename "$system_path")"
        else
            echo "  - Skipping system $system_path (not found in theme as $clean_name)"
        fi
    done
}

set_grub_theme() {
    local theme_name="$1"
    local theme_dir="$THEME_BASE_DIR/$theme_name"
    local grub_theme_file="$theme_dir/grubtheme"
    
    if [[ ! -f "$grub_theme_file" ]]; then
        echo "  - Skipping GRUB theme (grubtheme file not found)"
        return 0
    fi
    
    local grub_theme_name=$(cat "$grub_theme_file" 2>/dev/null)
    if [[ -z "$grub_theme_name" ]]; then
        echo "  - Skipping GRUB theme (empty grubtheme file)"
        return 0
    fi
    
    local grub_dir=$(get_grub_dir)
    if [[ $? -ne 0 ]]; then
        echo "  - Skipping GRUB theme ($grub_dir)"
        return 0
    fi
    
    local grub_config="/etc/default/grub"
    local theme_txt="$grub_dir/themes/$grub_theme_name/theme.txt"
    
    if [[ ! -f "$theme_txt" ]]; then
        echo "  - Skipping GRUB theme (theme.txt not found at $theme_txt)"
        return 0
    fi
    
    if [[ ! -f "$grub_config.bak" ]]; then
        sudo cp "$grub_config" "$grub_config.bak"
    fi
    
    if sudo grep -q "^GRUB_THEME=" "$grub_config"; then
        sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"$theme_txt\"|" "$grub_config"
    else
        echo "GRUB_THEME=\"$theme_txt\"" | sudo tee -a "$grub_config" >/dev/null
    fi
    
    echo "GRUB: Set theme to $grub_theme_name"
    
    if [[ -x "$(command -v update-grub)" ]]; then
        sudo update-grub 2>&1
    elif [[ -x "$(command -v grub2-mkconfig)" ]]; then
        sudo grub2-mkconfig -o "$grub_dir/grub.cfg" 2>&1
    elif [[ -x "$(command -v grub-mkconfig)" ]]; then
        sudo grub-mkconfig -o "$grub_dir/grub.cfg" 2>&1
    else
        echo "  - Warning: Unable to update GRUB configuration automatically"
    fi
}

reload_dwm() {
    xrdb merge "$HOME/.Xresources"
    xdotool key --window 0 alt+shift+s
}

reload_st() {
    pgrep st >/dev/null && pkill -USR1 st
}

reload_xsettingsd() {
    killall xsettingsd
    xsettingsd &!
}

reload_zsh() {
    pgrep zsh >/dev/null && pkill -USR1 -u "$(id -u)" zsh
}

update_nvim() {
    local theme_name="$1"
    local colorscheme=$(cat "$THEME_BASE_DIR/$theme_name/nvimtheme" 2>/dev/null || echo "ultraviolence")
    
    find "${TMPDIR:-/tmp}" -name "nvim-${USER}-*" -type s -print0 2>/dev/null \
        | xargs -0 -I{} nvim --server {} --remote-send "<Esc>:colorscheme $colorscheme<CR>"
    sleep 1
    find "${TMPDIR:-/tmp}" -name "nvim-${USER}-*" -type s -print0 2>/dev/null \
        | xargs -0 -I{} nvim --server {} --remote-send '<Esc>:Lazy reload lualine.nvim<CR>'
}

yazi-restart() {
    if pgrep -x yazi >/dev/null; then
        local pids=($(pgrep -x yazi))
        local restarted=0
        
        for pid in "${pids[@]}"; do
            local current_pid=$pid
            local wid=""
            
            while [[ $current_pid -gt 1 && -z "$wid" ]]; do
                wid=$(xdotool search --all --pid $current_pid 2>/dev/null | head -1)
                
                if [[ -n "$wid" ]]; then
                    break
                fi
                
                current_pid=$(ps -o ppid= -p $current_pid 2>/dev/null | tr -d ' ')
                [[ -z "$current_pid" ]] && break
            done
            
            kill $pid
            
            if [[ -n "$wid" ]]; then
                printf "Restarting yazi in window %s (found via PID %s)\n" "$wid" "$current_pid"
                
                xdotool windowactivate "$wid"
                sleep 0.1
                xdotool type --window "$wid" "yazi"
                xdotool key --window "$wid" Return
                ((restarted++))
            else
                printf "Could not find window for yazi PID %s\n" "$pid"
            fi
        done
        
        printf "Restarted yazi in %d window(s)\n" "$restarted"
    fi
}

set_background() {

    killall screenweaver 2>/dev/null || true
    set_background.sh "$HOME/.backgrounds"

}

set_theme() {
    local theme_name="$1"
    local theme_dir="$THEME_BASE_DIR/$theme_name"
    
    if [[ ! -d "$theme_dir" ]]; then
        echo "Error: Theme '$theme_name' does not exist"
        return 1
    fi
    
    echo "$theme_name" > "$THEME_FILE"
    flip_all_configs "$theme_name"
    flip_system_configs "$theme_name"
    xrdb merge "$HOME/.Xresources"
    set_grub_theme "$theme_name"
    set_background
    reload_st
    update_nvim "$theme_name"
    reload_xsettingsd
    reload_zsh
    killall dunst
    yazi-restart
    reload_dwm
    
    
    echo "${theme_name^} theme activated!"
}

list_themes() {
    local themes=($(get_available_themes))
    if [[ ${#themes[@]} -eq 0 ]]; then
        echo "No themes found in $THEME_BASE_DIR"
        return 1
    fi
    
    for theme in "${themes[@]}"; do
        if [[ "$theme" == "$DWM_THEME" ]]; then
            echo "$theme (current)"
        else
            echo "$theme"
        fi
    done
}

case "${1:-}" in
    "list")
        list_themes
        ;;
    "")
        next_theme=$(get_next_theme "$DWM_THEME")
        set_theme "$next_theme"
        ;;
    *)
        set_theme "$1"
        ;;
esac
