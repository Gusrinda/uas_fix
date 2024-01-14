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

// Fungsi untuk melakukan update data supporter berdasarkan ID
function updateSupporterById($conn, $id, $nama, $alamat, $tglDaftar, $noTelpon, $fotoPath)
{
    $stmt = $conn->prepare("UPDATE supporter SET nama=?, alamat=?, tgl_daftar=?, no_telpon=?, foto=? WHERE id=?");
    $stmt->bind_param("sssssi", $nama, $alamat, $tglDaftar, $noTelpon, $fotoPath, $id);
    $result = $stmt->execute();
    $stmt->close();

    return $result;
}

// Menerima data dari Flutter untuk update
$idToUpdate = $_POST['id'];
$namaUpdate = $_POST['nama'];
$alamatUpdate = $_POST['alamat'];
$tglDaftarUpdate = $_POST['tgl_daftar'];
$noTelponUpdate = $_POST['no_telpon'];


if (isset($_FILES["image"])) {
    $file_tmp = $_FILES['image']['tmp_name'];
    $file_name = $_FILES['image']['name'];
    $file_destination = '../../uploads/' . $file_name;
    move_uploaded_file($file_tmp, $file_destination);
}

// Melakukan update data supporter
$resultUpdate = updateSupporterById($conn, $idToUpdate, $namaUpdate, $alamatUpdate, $tglDaftarUpdate, $noTelponUpdate, $file_name);

// Memeriksa keberhasilan update
if ($resultUpdate) {
    echo json_encode(["status" => "success", "message" => "Data supporter berhasil diupdate"]);
} else {
    echo json_encode(["status" => "error", "message" => "Gagal update data supporter"]);
}

// Menutup koneksi
$conn->close();
?>