# scripts/postinstall.sh
#!/bin/bash
echo "Post-installation script running..."
sudo pacman -Syu --noconfirm
echo "Installation complete."
