<div align="center">
 
# Api Free Lins-MD
<p align="center">
<a href="https://whatsapp.com/channel/0029VaeQHirJ93waiykxjF2L"><img title="LINS APIs" src="https://img.shields.io/badge/LINS APIs-blue?colorA=%23ff0000&colorB=%23017e40&style=for-the-badge"></a>
</p>
<p align="center">
<a href="https://github.com/Linsofc"><img title="Author" src="https://img.shields.io/badge/Author-LINS OFFICIAL-orange.svg?style=for-the-badge&logo=github"></a>
</p>
<p align="center">
<a href="https://github.com/Linsofc/Api-free-Lins-MD/followers"><img title="Followers" src="https://img.shields.io/github/followers/Linsofc?color=red&style=flat-square"></a>
<a href="https://github.com/Linsofc/Api-free-Lins-MD/stargazers"><img title="Stars" src="https://img.shields.io/github/stars/Linsofc/Api-free-Lins-MD?color=blue&style=flat-square"></a>
<a href="https://github.com/Linsofc/Api-free-Lins-MD/network/members"><img title="Forks" src="https://img.shields.io/github/forks/Linsofc/Api-free-Lins-MD?color=red&style=flat-square"></a>
<a href="https://github.com/Linsofc/Api-free-Lins-MD/watchers"><img title="Watching" src="https://img.shields.io/github/watchers/Linsofc/Api-free-Lins-MD?label=Watchers&color=blue&style=flat-square"></a>
</p>
<p align='center'>
   <a href="https://www.youtube.com/@linsofficiall"><img height="30" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/YouTube_icon_%282013-2017%29.png/800px-YouTube_icon_%282013-2017%29.png"></a>&nbsp;&nbsp;
   <a href="https://instagram.com/rijalsavior"><img height="30" src="https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png"></a>
</P>

Hati-hati saat menggunakan API ini, salah implementasi bisa menyebabkan error 😅.
</div>

---

## Fitur
- Games
- Islamic
- Random
- Walpaper
- dll malas ngetik 😒

---

## Cara Penggunaan
1. Clone repository ini:
   ```bash
   git clone https://github.com/Linsofc/Api-free-Lins-MD.git

2. Masuk ke directory db
   ```bash
   cd Api-free-Lins-MD

3. Copy semua database
   ```bash
   cp -r db $HOME
   
4. Pindah ke database kalian

## Cara Menggunakan fetch
1. Initialisasi package
   ```bash
   npm init -y

2. Install modul fetch
   ```bash
   npm i node-fetch

3. Membuat file baru
   ```bash
   touch index.js

4. Isi codingan file index.js
   ```bash
   const fetch = require("node-fetch")
   async function kisahNabi(nabi) {
    try {
        // Fetch data dari URL
        let response = await fetch(
            `https://raw.githubusercontent.com/Linsofc/Api-free-Lins-MD/main/db/islamic/kisahNabi/${nabi}.json`
        );

        // Periksa apakah response sukses
        if (!response.ok) {
            throw new Error(`Gagal mengambil data untuk Nabi ${nabi}: ${response.statusText}`);
        }

        // Parse JSON
        let kisah = await response.json();

        // Format hasil
        let hasil = `Nabi: ${kisah.name}\n` +
                    `Tanggal Lahir: ${kisah.thn_kelahiran}\n` +
                    `Tempat Lahir: ${kisah.tmp}\n` +
                    `Usia: ${kisah.usia}\n` +
                    `Kisah: ${kisah.description}`;

        return hasil;
    } catch (error) {
        // Tangani error
        return `Terjadi kesalahan: ${error.message}`;
    }
}

let data = kisahNabi("adam")
console.log(data)
   
<p>
 © Lins MD
</p>
