# Shortcuts Quick Reference

Modifier legend (dwm/st/tabbed/dmenu):

- `Mod` = Alt (`Mod1Mask`) — primary window-manager modifier
- `Sup` = Super / Windows key (`Mod4Mask`) — secondary "ALTMOD"
- `S` = Shift
- `C` = Control
- `TERMMOD` (st) = `Ctrl+Shift`
- `MODKEY` (tabbed) = `Ctrl`

---

## DWM (window manager)

### Launchers

| Keys               | Action                             |
| ------------------ | ---------------------------------- |
| `Mod + p`          | dmenu_run (3-col, 10-line grid)    |
| `Mod + S + Return` | spawn `st` terminal                |
| `Sup + S + Return` | spawn `tabbed -r 2 st` (tabbed st) |
| `Mod + ` `` ` ``   | toggle scratchpad (`st 120x34`)    |
| `Mod + b`          | toggle bar                         |

### Focus / stack

| Keys                          | Action                              |
| ----------------------------- | ----------------------------------- |
| `Mod + j` / `Mod + k`         | focus next / prev visible client    |
| `Mod + S + j` / `Mod + S + k` | focus next / prev hidden client     |
| `Mod + Tab`                   | alt-tab overlay (workspace preview) |
| `Mod + Delete`                | alt-tab previous direction          |

### Layout / master area

| Keys                  | Action                             |
| --------------------- | ---------------------------------- |
| `Mod + i` / `Mod + d` | inc / dec nmaster                  |
| `Mod + h` / `Mod + l` | shrink / grow master (mfact ±0.05) |
| `Mod + S + C + j/k`   | move client up / down stack        |
| `Mod + Return`        | zoom (promote to master)           |
| `Mod + t`             | tile layout `[]=`                  |
| `Mod + f`             | floating layout `><>`              |
| `Mod + m`             | monocle `[M]`                      |
| `Mod + u`             | centered master `\|M\|`            |
| `Mod + o`             | centered floating master `>M>`     |
| `Mod + Space`         | reset to default layout            |
| `Mod + S + Space`     | toggle floating for current window |

### Window actions

| Keys          | Action                  |
| ------------- | ----------------------- |
| `Mod + S + c` | kill client             |
| `Mod + a`     | show client             |
| `Mod + S + a` | show all hidden clients |
| `Sup + h`     | hide client             |

### Tags (workspaces 1–9)

| Keys                         | Action                       |
| ---------------------------- | ---------------------------- |
| `Mod + N`                    | view tag N                   |
| `Mod + C + N`                | toggle tag N visibility      |
| `Mod + S + N`                | move client to tag N         |
| `Mod + C + S + N`            | toggle client on tag N       |
| `Mod + 0`                    | view all tags                |
| `Mod + S + 0`                | tag client on all tags       |
| `Mod + Right` / `Mod + Left` | view next / prev tag         |
| `Mod + S + Right/Left`       | move client to next/prev tag |

### Monitors

| Keys                          | Action                             |
| ----------------------------- | ---------------------------------- |
| `Sup + Tab`                   | focus next monitor                 |
| `Sup + S + Tab`               | focus prev monitor                 |
| `Sup + N`                     | focus Nth monitor                  |
| `Sup + S + N`                 | move client to Nth monitor         |
| `Mod + S + ,` / `Mod + S + .` | move client to prev / next monitor |

### Gaps / config

| Keys                  | Action                     |
| --------------------- | -------------------------- |
| `Mod + -` / `Mod + =` | dec / inc gaps             |
| `Mod + S + =`         | reset gaps to 0            |
| `Mod + S + s`         | reload Xresources (`xrdb`) |
| `Mod + S + q`         | quit dwm                   |

### Spawned utilities

| Keys                | Action                      |
| ------------------- | --------------------------- |
| `Mod + c`           | `dmenu_cliphist add`        |
| `Sup + v`           | `dmenu_cliphist sel`        |
| `Mod + S + Esc`     | `dmenu_sys` (system menu)   |
| `Sup + Esc`         | `change_keyboard_layout.sh` |
| `Mod + s`           | `change_theme.sh`           |
| `Mod + Sup + S + s` | pavucontrol                 |
| `Mod + Sup + S + b` | blueman-manager             |
| `Mod + Sup + S + d` | discord                     |
| `Mod + Sup + S + o` | obsidian                    |
| `Mod + Sup + S + v` | stremio                     |
| `XF86Search`        | open `$BROWSER`             |

### Media / brightness

| Keys                       | Action                 |
| -------------------------- | ---------------------- |
| `XF86AudioLowerVolume`     | `pamixer -d 5`         |
| `XF86AudioRaiseVolume`     | `pamixer -i 5`         |
| `XF86AudioMute`            | `pamixer -t`           |
| `XF86MonBrightnessUp/Down` | `xbacklight ±5`        |
| `XF86AudioPrev/Play/Next`  | `mpc prev/toggle/next` |

### Screenshots

| Keys        | Action                                              |
| ----------- | --------------------------------------------------- |
| `Print`     | full screen → clipboard + `~/Pictures/Screenshots/` |
| `S + Print` | region select → clipboard + Screenshots             |

### Mouse (dwm)

- Tag bar: L-click view, R-click toggle view; with Mod: L-click tag, R-click toggle tag
- Layout symbol: L-click default layout, R-click monocle
- Win title: L-click toggle hidden, M-click zoom
- Client: `Mod + L` move, `Mod + M` toggle float, `Mod + R` resize
- Status text: buttons 1–5 → `dwmblocks` signals 1–5; `S + L` → 6; `S + R` → edit `blocks.def.h`

---

## dmenu

- `-c` centered, `-l 10` 10 lines, `-g 3` 3 columns, fuzzy match enabled.
- Standard dmenu keys apply: `↑/↓` or `Tab/S-Tab` to move, `Return` to select, `Esc` to cancel, `C-p/C-n` prev/next.

---

## st (terminal)

`MODKEY = Alt`, `TERMMOD = Ctrl+Shift`.

| Keys                     | Action                        |
| ------------------------ | ----------------------------- |
| `Any + Break`            | send break                    |
| `C + Print`              | toggle printer                |
| `S + Print`              | print screen                  |
| `Any + Print`            | print selection               |
| `Ctrl+S + PgUp` / `PgDn` | zoom font in / out            |
| `Ctrl+S + Home`          | reset zoom                    |
| `Ctrl+S + c` / `v`       | clipboard copy / paste        |
| `Ctrl+S + y`             | clipboard paste (alt)         |
| `S + Insert`             | clipboard paste               |
| `Ctrl+S + o` / `p`       | alpha +0.05 / -0.05           |
| `S + PgUp` / `S + PgDn`  | scroll history up / down      |
| `Ctrl+S + NumLock`       | toggle numlock                |
| `Ctrl+S + u`             | url picker (`xurls \| dmenu`) |
| `Ctrl+S + m`             | set bg color (`#008000`)      |
| `Ctrl+S + Esc`           | enter keyboard-select mode    |

Mouse:

- `M-click` paste, `Wheel` scroll, `S + Wheel` scroll history, `Mod1` (Alt) drag = rectangular selection.

---

## tabbed

`MODKEY = Ctrl`.

| Keys                      | Action                       |
| ------------------------- | ---------------------------- |
| `C + S + Return`          | new tab (focus once / spawn) |
| `C + Tab`                 | next tab                     |
| `C + S + Tab`             | previous tab                 |
| `C + S + l` / `C + S + h` | rotate +1 / -1               |
| `C + S + j` / `C + S + k` | move tab left / right        |
| `C + Esc`                 | rotate to first              |
| `C + ` `` ` ``            | tab selector (xprop dmenu)   |
| `C + 1..9, 0`             | jump to tab N                |
| `C + q`                   | kill client                  |
| `C + u`                   | focus urgent tab             |
| `C + S + u`               | toggle urgentswitch          |
| `F11`                     | fullscreen                   |

---

## Neovim

Leader = `<Space>`. LSP-prefixed keys assume LSP attached (Lspsaga).

### Buffers & files

| Keys               | Action              |
| ------------------ | ------------------- |
| `<leader>bn`       | next buffer         |
| `<leader>bp`       | previous buffer     |
| `<leader>bb`       | last buffer (`e #`) |
| `<leader>` `` ` `` | last buffer (alias) |
| `<leader>m`        | NvimTree focus      |
| `<leader>e`        | NvimTree toggle     |
| `<leader>pa`       | echo full file path |
| `<C-p>`            | `FzfLua files`      |

### Window navigation (works through tmux via vim-tmux-navigator)

| Keys          | Action                                |
| ------------- | ------------------------------------- |
| `<C-h/j/k/l>` | move to left / down / up / right pane |
| `<leader>sv`  | vsplit                                |
| `<leader>sh`  | hsplit                                |
| `<leader>sm`  | MaximizerToggle                       |

### Edit / misc

| Keys               | Action                             |
| ------------------ | ---------------------------------- |
| `<` / `>` (visual) | dedent / indent and keep selection |
| `<C-_>` n/v        | toggle comment (gcc)               |
| `<F8>`             | TagbarToggle                       |
| `D C S X` n/v      | delete/change/sub/x without yank   |
| `dd cc ss x`       | delete/change/sub/x without yank   |
| `P` (visual)       | paste without overwriting register |

### Telescope

| Keys              | Action                           |
| ----------------- | -------------------------------- |
| `<leader>ff`      | find files                       |
| `<leader>fg`      | live grep                        |
| `<leader>fb`      | buffers                          |
| `<leader>fk`      | keymaps                          |
| `<leader>fh`      | help tags                        |
| `<C-j>` / `<C-k>` | next / prev result (insert mode) |

### LSP (Lspsaga)

| Keys              | Action                            |
| ----------------- | --------------------------------- |
| `K`               | hover doc                         |
| `<leader>fd`      | finder (references / definitions) |
| `<leader>gd`      | peek definition                   |
| `<leader>gD`      | goto definition                   |
| `<leader>gS`      | goto definition in vsplit         |
| `<leader>ca`      | code action                       |
| `<leader>rn`      | rename                            |
| `<leader>D`       | line diagnostics                  |
| `<leader>d`       | cursor diagnostics                |
| `<leader>pd`      | jump to prev diagnostic           |
| `<leader>nd`      | jump to next diagnostic           |
| `<C-j>` / `<C-k>` | next / prev (in saga windows)     |

### Python / DAP (active when pyright attached)

| Keys         | Action                                 |
| ------------ | -------------------------------------- |
| `<leader>oi` | PyrightOrganizeImports (or TS variant) |
| `<leader>db` | DapToggleBreakpoint                    |
| `<leader>dr` | DapContinue (run/continue)             |
| `<leader>dc` | DapContinue                            |
| `<leader>do` | DapStepOver                            |
| `<leader>di` | DapStepInto                            |
| `<leader>dO` | DapStepOut                             |
| `<leader>dq` | DapTerminate                           |
| `<leader>du` | DapUIToggle                            |
| `<leader>dt` | dap-python test_method                 |

### nvim-cmp (completion)

| Keys              | Action                   |
| ----------------- | ------------------------ |
| `<C-j>` / `<C-k>` | next / prev suggestion   |
| `<C-Space>`       | trigger completion       |
| `<C-b>` / `<C-f>` | scroll docs up / down    |
| `<C-e>`           | abort completion         |
| `<CR>`            | confirm (no auto-select) |

---

## tmux

Prefix = `Ctrl+B`. Mode keys = vi. Mouse on. Status at top.

### Core

| Keys         | Action                            |
| ------------ | --------------------------------- |
| `<prefix> x` | kill pane                         |
| `<prefix> *` | tmux-cowboy: kill foreground proc |
| `<prefix> I` | TPM: install plugins              |
| `<prefix> U` | TPM: update plugins               |

### Copy mode (vi)

| Keys          | Action                             |
| ------------- | ---------------------------------- |
| `<prefix> [`  | enter copy mode                    |
| `v`           | begin selection                    |
| `C-v`         | toggle rectangle (block) selection |
| `y` / `Enter` | copy selection                     |

### tmux-yank

| Keys                  | Action                         |
| --------------------- | ------------------------------ |
| `<prefix> y` (normal) | copy command line to clipboard |
| `<prefix> Y` (normal) | copy pane PWD to clipboard     |
| `y` (copy mode)       | copy to system clipboard       |
| `Y` (copy mode)       | "put" — paste to command line  |

### vim-tmux-navigator

- `C-h/j/k/l` traverses tmux panes and Vim splits seamlessly.

### tmux-session-manager

| Keys         | Action                     |
| ------------ | -------------------------- |
| `<prefix> T` | open session-manager popup |
| `Ctrl-s`     | list tmux sessions only    |
| `Ctrl-x`     | list zoxide results only   |
| `Ctrl-f`     | find by directory          |

### tmux-sessionx (`<prefix> o`)

| Keys                | Action                       |
| ------------------- | ---------------------------- |
| `<prefix> o`        | open sessionx                |
| `Alt + Backspace`   | delete selected session      |
| `Ctrl-u` / `Ctrl-d` | scroll preview up / down     |
| `Ctrl-p` / `Ctrl-n` | select session up / down     |
| `Ctrl-r`            | rename session ("read")      |
| `Ctrl-w`            | window mode                  |
| `Ctrl-x`            | fuzzy read `~/.config`       |
| `Ctrl-e`            | expand PWD to local dirs     |
| `Ctrl-b`            | back to first query          |
| `Ctrl-t`            | tree view (sessions+windows) |
| `Ctrl-/`            | tmuxinator list              |
| `Ctrl-g`            | fzf-marks                    |
| `?`                 | toggle preview pane          |

### tmux-fzf

| Keys         | Action        |
| ------------ | ------------- |
| `<prefix> F` | open tmux-fzf |

---

## Quick cross-reference: same key, different contexts

| Key      | dwm                                 | st  | tabbed             | nvim                | tmux |
| -------- | ----------------------------------- | --- | ------------------ | ------------------- | ---- |
| `Tab`    | `Mod` alt-tab                       | —   | `Ctrl` next tab    | —                   | —    |
| `Return` | `Mod` zoom / `Mod+S` term           | —   | `Ctrl+S` new tab   | (cmp confirm)       | —    |
| `j/k`    | `Mod` focus stack                   | —   | `C+S` move tab     | `<C-…>` pane / cmp  | —    |
| `h/l`    | `Mod` resize master                 | —   | `C+S` rotate       | `<C-…>` pane        | —    |
| `c`      | `Mod` cliphist add; `Mod+S` kill    | —   | —                  | `<leader>ca` action | —    |
| `q`      | `Mod+S` quit dwm                    | —   | `Ctrl` kill client | —                   | —    |
| `Esc`    | `Mod+S` dmenu_sys; `Sup` kbd layout | —   | `Ctrl` rotate→0    | —                   | —    |
