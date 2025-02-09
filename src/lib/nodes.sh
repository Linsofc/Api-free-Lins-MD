#!/bin/bash

# Warna teks
BLUE="\e[34m"
GREEN="\e[32m"
NC="\e[0m"

# Variabel tetap (silakan ubah sesuai kebutuhan)
location_name="LinsSg"
location_description="Created By Lins Officiall"
node_name="LinsSg"
ram=1600000  # Dalam MB
disk_space=1600000  # Dalam MB
locid=1  # ID Lokasi Default

echo -e "                                                       "
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "${BLUE}[+]                   CREATE NODE LINS                    [+]${NC}"
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "                                                       "

# Hanya meminta input domain dari pengguna
read -p "Masukkan domain: " domain

# Ubah ke direktori pterodactyl
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:location:make <<EOF
$location_name
$location_description
EOF

# Membuat nodes baru
php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$ram
$ram
$disk_space
$disk_space
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

echo -e "                                                       "
echo -e "${GREEN}[+] =============================================== [+]${NC}"
echo -e "${GREEN}[+]        CREATE NODE & LOCATION SUKSES             [+]${NC}"
echo -e "${GREEN}[+] =============================================== [+]${NC}"
echo -e "                                                       "

sleep 2
clear
exit 0
