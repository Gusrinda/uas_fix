<?php
// Koneksi ke database (sesuaikan dengan konfigurasi Anda)
$host = "localhost";
$username = "root";
$password = "";
$database = "uas";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fungsi untuk menambahkan data klub ke dalam database
function addClub($conn, $namaKlub, $tglBerdiri, $kondisiKlub, $kotaKlub, $peringkat, $hargaKlub)
{
    $stmt = $conn->prepare("INSERT INTO klub (nama_klub, tgl_berdiri, kondisi_klub, kota_klub, peringkat, harga_klub) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssi", $namaKlub, $tglBerdiri, $kondisiKlub, $kotaKlub, $peringkat, $hargaKlub);
    $result = $stmt->execute();
    $stmt->close();

    return $result;
}

// Menerima data dari Flutter untuk menambahkan klub
$namaKlub = $_POST['nama_klub'];
$tglBerdiri = $_POST['tgl_berdiri'];
$kondisiKlub = $_POST['kondisi_klub'];
$kotaKlub = $_POST['kota_klub'];
$peringkat = $_POST['peringkat'];
$hargaKlub = $_POST['harga_klub'];

// Menambahkan klub ke dalam database
$resultAddClub = addClub($conn, $namaKlub, $tglBerdiri, $kondisiKlub, $kotaKlub, $peringkat, $hargaKlub);

// Memeriksa keberhasilan penambahan klub
if ($resultAddClub) {
    echo json_encode(["status" => "success", "message" => "Data klub berhasil ditambahkan"]);
} else {
    echo json_encode(["status" => "error", "message" => "Gagal menambahkan data klub"]);
}

// Menutup koneksi
$conn->close();
?>