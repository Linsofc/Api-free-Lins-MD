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
locid=4  # ID Lokasi Default
ip_address="0.0.0.0"
ip_alias="Linsofc"
allocation_start=2000
allocation_end=2200

echo -e "                                                       "
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "${BLUE}[+]                   CREATE NODE LINS                    [+]${NC}"
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "                                                       "

# Meminta input domain dari pengguna
read -p "Masukkan domain: " domain

# Ubah ke direktori Pterodactyl
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:location:make <<EOF
$location_name
$location_description
EOF

# Membuat node baru
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

echo -e "                                                       "
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "${BLUE}[+]               CREATE ALLOCATION PORTS                 [+]${NC}"
echo -e "${BLUE}[+] =============================================== [+]${NC}"
echo -e "                                                       "

# Menambahkan alokasi IP dengan alias
php artisan p:node:allocation:create $node_name $ip_address --alias=$ip_alias

# Loop untuk menambahkan alokasi port dari 2000 hingga 2200
for port in $(seq $allocation_start $allocation_end); do
    php artisan p:allocation:create $node_name $ip_address $port
done

echo -e "                                                       "
echo -e "${GREEN}[+] =============================================== [+]${NC}"
echo -e "${GREEN}[+]       ALLOCATION PORTS CREATED SUCCESSFULLY        [+]${NC}"
echo -e "${GREEN}[+] =============================================== [+]${NC}"
echo -e "                                                       "

sleep 2
clear
exit 0
