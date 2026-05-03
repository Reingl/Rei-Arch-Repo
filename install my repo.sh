#!/bin/bash

CONF="/etc/pacman.conf"

# backup first
sudo cp "$CONF" "${CONF}.bak"

# avoid duplicate entries
if grep -q "\[Rei-arch-repo\]" "$CONF"; then
    echo "Repo already exists in pacman.conf"
    exit 0
fi

# append repo
sudo bash -c "cat <<'EOF' >> $CONF

[Rei-arch-repo]
SigLevel = Optional TrustAll
Server = https://raw.githubusercontent.com/Reingl/Rei-Arch-Repo/main/
EOF"

echo "Rei-arch-repo added successfully."

# refresh package databases
sudo pacman -Sy
