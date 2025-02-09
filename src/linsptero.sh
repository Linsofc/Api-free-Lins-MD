#!/bin/bash

# Fungsi untuk menampilkan pesan error dan keluar dari script
error_exit() {
    echo "[ERROR] $1"
    exit 1
}

# Meminta input domain sebelum menjalankan instalasi
read -p "Silahkan masukkan domain Anda: " domain

# Validasi domain tidak kosong
if [[ -z "$domain" ]]; then
    error_exit "Domain tidak boleh kosong!"
fi

# Periksa apakah Expect terinstal, jika tidak, instal
if ! command -v expect &> /dev/null; then
    echo "[INFO] Expect belum terinstal. Menginstall sekarang..."
    sudo apt update && sudo apt install -y expect || error_exit "Gagal menginstal Expect!"
fi

# Unduh script installer ke file sementara
installer_file="/tmp/linsptero.sh"
installer_url="https://raw.githubusercontent.com/Linsofc/Api-free-Lins-MD/main/src/linsptero.sh"

echo "[INFO] Mengunduh skrip instalasi dari $installer_url..."
curl -s "$installer_url" -o "$installer_file" || error_exit "Gagal mengunduh skrip instalasi!"
chmod +x "$installer_file"

# Jalankan Expect untuk input otomatis
expect <<EOF
set timeout -1

spawn bash "$installer_file"

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

echo "[INFO] Instalasi selesai."
