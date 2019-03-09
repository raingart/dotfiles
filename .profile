# copied, and edited, from ~/.profile
# used for graphical sessions

## Make Qt5 applications be able to get user set GTK+ theme

# Gtk themes
export DESKTOP_SESSION="gnome"
export QT_QPA_PLATFORMTHEME="qt5ct"
export FONTCONFIG_FILE="/etc/fonts/"
export PATH="$PATH:$HOME/bin"

## Ensure that GTK themes are applied uniformly in the Desktop Environment
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# for qt5 apps
#~ export QT_STYLE_OVERRIDE=GTK+

# include sbin in PATH
if [ -d "/sbin" ] ; then
    PATH="/sbin:$PATH"
fi
if [ -d "/usr/sbin" ] ; then
    PATH="/usr/sbin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d ${HOME}/bin ] ; then
    PATH="${HOME}"/bin:"${PATH}"
fi
