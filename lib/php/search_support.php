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

// Fungsi untuk mencari supporter berdasarkan nama
function searchSupporterByName($conn, $nama)
{
    $stmt = $conn->prepare("SELECT * FROM supporter WHERE nama LIKE ?");
    $nama = "%" . $nama . "%";
    $stmt->bind_param("s", $nama);
    $stmt->execute();

    $result = $stmt->get_result();

    $supporters = array();
    while ($row = $result->fetch_assoc()) {
        $supporters[] = $row;
    }

    $stmt->close();

    return $supporters;
}

// Menerima data dari Flutter (nama untuk pencarian)
$namaToSearch = $_POST['nama'];

// Melakukan pencarian supporter berdasarkan nama
$hasilPencarian = searchSupporterByName($conn, $namaToSearch);

// Mengembalikan hasil pencarian ke Flutter
echo json_encode($hasilPencarian);

// Menutup koneksi
$conn->close();
?>