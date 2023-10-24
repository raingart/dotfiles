# used for graphical sessions

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export DESKTOP_SESSION="gnome"
export QT_QPA_PLATFORMTHEME="qt5ct"
export $(dbus-launch)

# fix open file/folder in appimage
if [ -z "$XDG_DATA_DIRS" ]; then
   # export XDG_DATA_HOME="$HOME/.local/share:/root/.local/share:/usr/local/share/:/usr/share/"
   # export XDG_DATA_DIRS="$HOME/.local/share:/root/.local/share:/usr/local/share/:/usr/share/"
   export XDG_DATA_DIRS=/usr/local/share:/usr/share
   # XDG_CONFIG_DIRS=/etc/xdg #default
fi

# include sbin in PATH
if [ -d "/sbin" ] ; then
    PATH="/sbin:$PATH"
fi
if [ -d "/usr/sbin" ] ; then
    PATH="/usr/sbin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # startx #openbox-session
# fi
# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty2 ]]; then
  # XKB_DEFAULT_LAYOUT=us MOZ_ENABLE_WAYLAND=1 GDK_BACKEND=wayland exec sway
# fi
