#!/bin/bash

# Meminta input domain panel dari user
read -p "Masukkan domain untuk panel (contoh: panel.example.com): " PANEL_DOMAIN

# Konfigurasi Panel
ADMIN_EMAIL="panel@linsofc.id"
ADMIN_USER="admin"
ADMIN_PASS="psswd"
TIMEZONE="Asia/Jakarta"

# Update sistem dan instal dependensi
echo "Memperbarui sistem dan menginstal dependensi..."
apt update && apt upgrade -y
apt install -y curl sudo zip unzip tar wget git cron socat net-tools dnsutils

# Mengatur timezone
echo "Mengatur timezone ke $TIMEZONE..."
timedatectl set-timezone "$TIMEZONE"

# Menjalankan instalasi Pterodactyl
echo "Menginstal Pterodactyl Panel..."
bash <(curl -s https://pterodactyl-installer.se) <<EOF
0
$TIMEZONE
$ADMIN_EMAIL
$ADMIN_EMAIL
$ADMIN_USER
admin
admin
$ADMIN_PASS
$PANEL_DOMAIN
y
y
y
y
y
yes
A
y
EOF

# Menampilkan informasi kredensial setelah instalasi selesai
echo "======================================="
echo " Instalasi Selesai! "
echo "======================================="
echo "URL Panel: https://$PANEL_DOMAIN"
echo "Admin Email: $ADMIN_EMAIL"
echo "Admin Username: $ADMIN_USER"
echo "Admin Password: $ADMIN_PASS"
echo "======================================="
