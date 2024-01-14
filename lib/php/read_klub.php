<?php
$conn = new mysqli('localhost', 'root', '', 'uas');
$query = mysqli_query($conn, "select * from klub");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);
?>