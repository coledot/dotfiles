#! /usr/bin/env bash

# disable the gnome extension hide top bar; it can cause video flickering issues
/usr/bin/gnome-extensions disable hidetopbar@mathieu.bidon.ca

# disable using windows key to show window overview
/usr/bin/gsettings set org.gnome.mutter overlay-key ''
