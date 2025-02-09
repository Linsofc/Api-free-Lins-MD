#!/bin/bash

# Meminta user untuk memasukkan domain
read -p "Masukkan domain untuk panel Pterodactyl (FQDN): " user_domain

# Jalankan installer Pterodactyl dan proses outputnya
bash <(curl -s https://pterodactyl-installer.se) | while read -r line; do
0
\n
\n
\n
Asia/Jakarta
    echo "$line"  # Cetak output agar bisa dilihat

    if [[ "$line" == *"Provide the email address that will be used to configure Let's Encrypt and Pterodactyl:"* ]]; then
        echo "lins@gmail.com"
    elif [[ "$line" == *"Email address for the initial admin account:"* ]]; then
        echo "lins@gmail.com"
    elif [[ "$line" == *"Username for the initial admin account:"* ]]; then
        echo "username"
    elif [[ "$line" == *"First name for the initial admin account:"* ]]; then
        echo "admin"
    elif [[ "$line" == *"Last name for the initial admin account:"* ]]; then
        echo "admin"
    elif [[ "$line" == *"Password for the initial admin account:"* ]]; then
        echo "psswd"
    elif [[ "$line" == *"Set the FQDN of this panel (panel.example.com):"* ]]; then
        echo "$user_domain"
    elif [[ "$line" == *"Do you want to automatically configure UFW (firewall)? (y/N):"* ]]; then
        echo "y"
    elif [[ "$line" == *"Do you want to automatically configure HTTPS using Let's Encrypt? (y/N):"* ]]; then
        echo "y"
    elif [[ "$line" == *"I agree that this HTTPS request is performed (y/N):"* ]]; then
        echo "y"
    elif [[ "$line" == *"Proceed anyways (your install will be broken if you do not know what you are doing)? (y/N):"* ]]; then
        echo "y"
    elif [[ "$line" == *"Initial configuration completed. Continue with installation? (y/N):"* ]]; then
        echo "y"
    elif [[ "$line" == *"Enable sending anonymous telemetry data? (yes/no) [yes]:"* ]]; then
        echo "yes"
    elif [[ "$line" == *"(A)gree/(C)ancel:"* ]]; then
        echo "A"
    elif [[ "$line" == *"Still assume SSL? (y/N):"* ]]; then
        echo "y"
    fi
done

echo "Instalasi selesai!"
