
typeset -TUx PATH path

export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/bin/firefox-developer-edition
export TERMINAL=/usr/bin/alacritty
export TERMINAL_CMD=/usr/bin/alacritty
alias vim=nvim
QT_QUICK_CONTROLS_STYLE=org.kde.desktop

# Added by Toolbox App
export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/.go
export CODESTATS_API_KEY=SFMyNTY.WkdGMmFXUnRhWEoyIyNNakUwTWprPQ.trS2oKbAgZM6rO4TdncPX8oCVf3KQEBpLlLlt-7EJxM
export VOLTA_HOME="$HOME/.volta"
export GHIDRA_INSTALL_DIR=/opt/ghidra/
custom_paths+=(
  $HOME/.local/share/bob/nvim-bin/ 
  $HOME/.config/bin 
  $HOME/.local/share/JetBrains/Toolbox/scripts 
  $GOPATH/bin 
  $VOLTA_HOME/bin
  $HOME/.krew/bin
)
for p in $custom_paths; do
  path=($p "$path[@]")
done
