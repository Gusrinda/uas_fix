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

// Fungsi untuk melakukan update data klub berdasarkan ID
function updateClubById($conn, $id, $namaKlub, $tglBerdiri, $kondisiKlub, $kotaKlub, $peringkat, $hargaKlub)
{
    $stmt = $conn->prepare("UPDATE klub SET nama_klub=?, tgl_berdiri=?, kondisi_klub=?, kota_klub=?, peringkat=?, harga_klub=? WHERE id=?");
    $stmt->bind_param("ssissii", $namaKlub, $tglBerdiri, $kondisiKlub, $kotaKlub, $peringkat, $hargaKlub, $id);
    $result = $stmt->execute();
    $stmt->close();

    return $result;
}

// Menerima data dari Flutter untuk update klub
$idToUpdate = $_POST['id'];
$namaKlubUpdate = $_POST['nama_klub'];
$tglBerdiriUpdate = $_POST['tgl_berdiri'];
$kondisiKlubUpdate = $_POST['kondisi_klub'];
$kotaKlubUpdate = $_POST['kota_klub'];
$peringkatUpdate = $_POST['peringkat'];
$hargaKlubUpdate = $_POST['harga_klub'];

// Melakukan update data klub
$resultUpdateClub = updateClubById($conn, $idToUpdate, $namaKlubUpdate, $tglBerdiriUpdate, $kondisiKlubUpdate, $kotaKlubUpdate, $peringkatUpdate, $hargaKlubUpdate);

// Memeriksa keberhasilan update klub
if ($resultUpdateClub) {
    echo json_encode(["status" => "success", "message" => "Data klub berhasil diupdate"]);
} else {
    echo json_encode(["status" => "error", "message" => "Gagal update data klub"]);
}

// Menutup koneksi
$conn->close();
?>