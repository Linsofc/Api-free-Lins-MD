#!/bin/bash

# Meminta input domain sebelum menjalankan instalasi
read -p "Masukkan domain panel Anda: " domain

# Periksa apakah Expect terinstal
if ! command -v expect &> /dev/null; then
    echo "Expect belum terinstal. Menginstall sekarang..."
    sudo apt update && sudo apt install expect -y
fi

# Menjalankan Expect untuk menangani input otomatis
expect <<EOF
set timeout -1

spawn bash <(curl -s https://pterodactyl-installer.se)

expect "Input 0-6:"
send "0\r"

expect "Database name (panel):"
send "\r"

expect "Database username (pterodactyl):"
send "\r"

expect "Password (press enter to use randomly generated password):"
send "\r"

expect "Select timezone [Europe/Stockholm]:"
send "Asia/Jakarta\r"

expect "Provide the email address that will be used to configure Let's Encrypt and Pterodactyl:"
send "admin@linsofc.com\r"

expect "Email address for the initial admin account:"
send "admin@linsofc.com\r"

expect "Username for the initial admin account:"
send "admin\r"

expect "First name for the initial admin account:"
send "First\r"

expect "Last name for the initial admin account:"
send "Last\r"

expect "Password for the initial admin account:"
send "psswd\r"

# Menggunakan input domain yang diberikan pengguna
expect "Set the FQDN of this panel (panel.example.com):"
send "$domain\r"

expect "Do you want to automatically configure UFW (firewall)? (y/N):"
send "y\r"

expect "Do you want to automatically configure HTTPS using Let's Encrypt? (y/N):"
send "y\r"

expect "I agree that this HTTPS request is performed (y/N):"
send "y\r"

expect "Proceed anyways (your install will be broken if you do not know what you are doing)? (y/N):"
send "y\r"

expect "Initial configuration completed. Continue with installation? (y/N):"
send "y\r"

expect "Enable sending anonymous telemetry data? (yes/no) [yes]:"
send "yes\r"

expect "(A)gree/(C)ancel:"
send "A\r"

expect "Still assume SSL? (y/N):"
send "y\r"

expect eof
EOF
