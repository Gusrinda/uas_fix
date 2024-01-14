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

// Menerima data ID dari Flutter
$idToDelete = $_POST['idToDelete'];

// Menyiapkan pernyataan SQL untuk menghapus data dari tabel 'supporter'
$stmt = $conn->prepare("DELETE FROM klub WHERE id = ?");
$stmt->bind_param("s", $idToDelete);

// Menjalankan pernyataan SQL
$result = $stmt->execute();

// Memeriksa keberhasilan penghapusan data
if ($result) {
    echo json_encode(["status" => "success", "message" => "Data klub berhasil dihapus"]);
} else {
    echo json_encode(["status" => "error", "message" => "Gagal menghapus data klub"]);
}

// Menutup koneksi
$stmt->close();
$conn->close();
?>