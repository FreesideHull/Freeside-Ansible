#!/usr/bin/env bash

echo "[FreesideConfig] [1 / 3] Installing dnf-automatic";

sudo dnf install -y dnf-automatic

echo "[FreesideConfig] [2 / 3] Updating configuration file";
config_filename="/etc/dnf/automatic.conf";
sed -e 's/apply_updates = no/apply_updates = yes/' <"${config_filename}" | sudo tee "${config_filename}.new";
sudo mv "${config_filename}" "${config_filename}.bak";
sudo mv "${config_filename}.new" "${config_filename}";

echo "[FreesideConfig] [3 / 3] Enabling systemd timer";

sudo systemctl enable --now dnf-automatic.timer;

echo "[FreesideConfig] Timer enabled. Current timer status:";
systemctl list-timers *dnf-*

echo "[FreesideConfig] Done! dnf-automatic configuration complete.";
