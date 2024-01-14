<?php
// Koneksi ke database (sesuaikan dengan konfigurasi Anda)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");
$host = "localhost";
$username = "root";
$password = "";
$database = "uas";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Menerima data dari Flutter
$nama = $_POST['nama'];
$alamat = $_POST['alamat'];
$tglDaftar = $_POST['tgl_daftar'];
$noTelpon = $_POST['no_telpon'];
// $foto = $_FILES['image']['name'];  // Mengambil nama file yang diunggah


if (isset($_FILES["image"])) {
    $file_tmp = $_FILES['image']['tmp_name'];
    $file_name = $_FILES['image']['name'];
    $file_destination = '../../uploads/' . $file_name;
    move_uploaded_file($file_tmp, $file_destination);
}

// Menyiapkan pernyataan SQL untuk memasukkan data ke dalam tabel 'supporter'
$stmt = $conn->prepare("INSERT INTO supporter (nama, alamat, tgl_daftar, no_telpon, foto) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssss", $nama, $alamat, $tglDaftar, $noTelpon, $file_name);

// Menjalankan pernyataan SQL
$result = $stmt->execute();

// Memeriksa keberhasilan penyisipan data
if ($result) {
    echo json_encode(["status" => "success", "message" => "Data supporter berhasil ditambahkan"]);
} else {
    echo json_encode(["status" => "error", "message" => "Gagal menambahkan data supporter"]);
}

// Menutup koneksi
$stmt->close();
$conn->close();
?>