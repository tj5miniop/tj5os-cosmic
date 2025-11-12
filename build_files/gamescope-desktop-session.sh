#!/bin/bash 

# Download files
cd /usr/bin
wget -O gamescope-session https://raw.githubusercontent.com/tj5miniop/tj5os-cosmic/refs/heads/main/system_files/usr/bin/gamescope-session
wget -O steamos-select-branch https://raw.githubusercontent.com/tj5miniop/tj5os-cosmic/refs/heads/main/system_files/usr/bin/steamos-select-branch
wget -O steamos-session-select https://raw.githubusercontent.com/tj5miniop/tj5os-cosmic/refs/heads/main/system_files/usr/bin/steamos-session-select

chmod +x *

cd /usr/share/applications
wget -O deckui.desktop https://raw.githubusercontent.com/tj5miniop/tj5os-cosmic/refs/heads/main/system_files/usr/share/applications/deckui.desktop


cd /usr/share/wayland-sessions
wget -O steamdeckui.desktop https://raw.githubusercontent.com/tj5miniop/tj5os-cosmic/refs/heads/main/system_files/usr/share/wayland-sessions/steamdeckui.desktop