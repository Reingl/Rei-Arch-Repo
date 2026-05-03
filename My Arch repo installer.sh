#!/bin/bash

CONF="/etc/pacman.conf"
REPO_NAME="Rei-arch-repo"
REPO_URL="https://raw.githubusercontent.com/Reingl/Rei-Arch-Repo/main/"

# always create backup first which dumbass wouldnt nglo
sudo cp "$CONF" "${CONF}.bak"

# check if repo already exists (do nothing if it does)
if grep -q "^\[$REPO_NAME\]" "$CONF"; then
    echo "[$REPO_NAME] already exists in pacman.conf. No changes made."
    exit 0
fi

# append repo safely (never touches existing config)
sudo bash -c "cat >> $CONF <<EOF

[$REPO_NAME]
SigLevel = Optional TrustAll
Server = $REPO_URL
EOF"

echo "[$REPO_NAME] successfully added without modifying existing repositories."

# refresh package database safely
sudo pacman -Sy
