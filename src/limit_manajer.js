const fs = require("fs");
const path = require("path");
const moment = require("moment-timezone");

// Fungsi untuk memastikan direktori atau file database ada
const ensureDirectoryExistence = (dirPath) => {
    if (!fs.existsSync(dirPath)) {
        fs.mkdirSync(path.dirname(dirPath), { recursive: true });
        console.log(`Direktori ${path.dirname(dirPath)} berhasil dibuat.`);
    }
};

// Fungsi untuk membaca database
const readDatabase = (dirPath) => {
    ensureDirectoryExistence(dirPath);

    if (!fs.existsSync(dirPath)) {
        fs.writeFileSync(dirPath, JSON.stringify([]));
        console.log(`File database dibuat di ${dirPath}.`);
    }
    const data = JSON.parse(fs.readFileSync(dirPath, "utf-8"));
    console.log(`Database berhasil dibaca dari ${dirPath}.`);
    return data;
};

// Fungsi untuk menulis data ke database
const writeDatabase = (dirPath, data) => {
    ensureDirectoryExistence(dirPath);
    fs.writeFileSync(dirPath, JSON.stringify(data, null, 2));
    console.log(`Database berhasil diperbarui di ${dirPath}.`);
};

// Fungsi untuk memeriksa dan menambahkan user
const checkAndAddUser = (id, limitAwal, dirPath, db) => {
    const userExists = db.some((user) => user.id === id);

    if (!userExists) {
        db.push({ id, amount: limitAwal });
        console.log(`User ${id} ditambahkan dengan limit awal ${limitAwal}.`);
        writeDatabase(dirPath, db);
    }
};

// Fungsi untuk reset limit pada waktu tertentu
const resetLimitAtCustomTime = async (time, limitAwal, dirPath, db) => {
    const [hours, minutes] = time.split(".").map(Number);

    // Waktu sekarang dalam zona waktu WIB
    const now = moment.tz("Asia/Jakarta");

    // Tentukan waktu reset berdasarkan WIB
    let resetTime = moment.tz(
        `${now.format("YYYY-MM-DD")} ${hours}:${minutes}:00`,
        "Asia/Jakarta"
    );

    // Jika waktu reset sudah lewat, tambahkan 1 hari
    if (now.isAfter(resetTime)) {
        resetTime.add(1, "day");
    }

    const msTillReset = resetTime.diff(now);
    const remaining = resetTime.diff(moment.tz("Asia/Jakarta"), "minutes");
    const jam = Math.floor(remaining / 60);
    const menit = remaining % 60;

    console.log(`Waktu sekarang (WIB): ${now.format("YYYY-MM-DD HH:mm:ss")}`);
    console.log(`Waktu reset berikutnya (WIB): ${resetTime.format("YYYY-MM-DD HH:mm:ss")}`);
    console.log(`Menunggu ${jam > 0 ? `${jam} Jam` : ""} ${menit > 0 ? `${menit} Menit` : ""} untuk reset limit.`);

    setTimeout(() => {
        db = readDatabase(dirPath); // Baca ulang database sebelum mereset
        db = db.map((user) => {
            if (user.amount < limitAwal) {
                user.amount = limitAwal;
            }
            return user;
        });

        writeDatabase(dirPath, db);
        console.log(
            `Limit semua user telah direset ke ${limitAwal} pada ${resetTime.format("YYYY-MM-DD HH:mm:ss")} (WIB).`
        );

        // Panggil ulang fungsi untuk reset limit di hari berikutnya
        resetLimitAtCustomTime(time, limitAwal, dirPath, db);
    }, msTillReset);
};

module.exports = { checkAndAddUser, resetLimitAtCustomTime };
