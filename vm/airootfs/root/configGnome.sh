#!/bin/bash

# settings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/gnome/background.png"
cp usr/local/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
mv usr/local/share/backgrounds/gnome/* /usr/share/backgrounds/gnome
dconf load / < root/gnome-config.txt
echo "Fondo de pantalla configurado correctamente."