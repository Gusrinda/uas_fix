-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 08 Mar 2023 pada 00.16
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_spk`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dusun`
--

CREATE TABLE `dusun` (
  `kdDusun` int(11) NOT NULL,
  `dusun` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kriteria`
--

CREATE TABLE `kriteria` (
  `kdKriteria` int(11) NOT NULL,
  `kriteria` varchar(100) NOT NULL,
  `sifat` char(1) NOT NULL,
  `bobot` decimal(3,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `kriteria`
--

INSERT INTO `kriteria` (`kdKriteria`, `kriteria`, `sifat`, `bobot`) VALUES
(3, 'Penguasaan_data', 'B', '0.25'),
(5, 'Penguasaan_lapangan', 'B', '0.25'),
(6, 'Koordinasi', 'B', '0.20'),
(7, 'Kedisiplinan', 'B', '0.20'),
(8, 'Pelaporan', 'B', '0.10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai`
--

CREATE TABLE `nilai` (
  `kdPenerima` int(11) NOT NULL,
  `kdKriteria` int(11) NOT NULL,
  `nilai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `nilai`
--

INSERT INTO `nilai` (`kdPenerima`, `kdKriteria`, `nilai`) VALUES
(4, 3, 3),
(4, 5, 3),
(4, 6, 3),
(4, 7, 3),
(4, 8, 3),
(5, 3, 2),
(5, 5, 4),
(5, 6, 3),
(5, 7, 1),
(5, 8, 2),
(6, 3, 5),
(6, 5, 5),
(6, 6, 4),
(6, 7, 2),
(6, 8, 5),
(7, 3, 4),
(7, 5, 4),
(7, 6, 3),
(7, 7, 4),
(7, 8, 5),
(8, 3, 5),
(8, 5, 5),
(8, 6, 4),
(8, 7, 5),
(8, 8, 4),
(9, 3, 5),
(9, 5, 5),
(9, 6, 5),
(9, 7, 5),
(9, 8, 5),
(10, 3, 1),
(10, 5, 2),
(10, 6, 3),
(10, 7, 4),
(10, 8, 5),
(11, 3, 2),
(11, 5, 4),
(11, 6, 2),
(11, 7, 2),
(11, 8, 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penerima`
--

CREATE TABLE `penerima` (
  `kdPenerima` int(11) NOT NULL,
  `kdDusun` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `penerima` varchar(50) NOT NULL,
  `NIK` varchar(50) NOT NULL,
  `jenis_kelamin` tinyint(1) NOT NULL,
  `alamat_lengkap` varchar(100) NOT NULL,
  `tempat_lahir` varchar(100) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `pekerjaan` varchar(100) NOT NULL,
  `penghasilan` double NOT NULL,
  `tanggungan_keluarga` int(11) NOT NULL,
  `riwayat_penyakit` varchar(100) NOT NULL,
  `kondisi_rumah` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `penerima`
--

INSERT INTO `penerima` (`kdPenerima`, `kdDusun`, `user_id`, `penerima`, `NIK`, `jenis_kelamin`, `alamat_lengkap`, `tempat_lahir`, `tgl_lahir`, `pekerjaan`, `penghasilan`, `tanggungan_keluarga`, `riwayat_penyakit`, `kondisi_rumah`) VALUES
(4, 0, 0, 'Kasmani', '', 0, '', '', '0000-00-00', '', 0, 0, '', ''),
(5, 0, 0, 'Kedah', '', 0, '', '', '0000-00-00', '', 0, 0, '', ''),
(6, 0, 0, 'Mesiyem', '', 0, '', '', '0000-00-00', '', 0, 0, '', ''),
(7, 0, 0, 'Tini', '', 0, '', '', '0000-00-00', '', 0, 0, '', ''),
(8, 0, 0, 'Resita', '', 0, '', '', '0000-00-00', '', 0, 0, '', ''),
(9, 0, 0, 'Paidi', '', 0, '', '', '0000-00-00', '', 0, 0, '', ''),
(10, 0, 0, 'Calon', '', 0, '', '', '0000-00-00', '', 0, 0, '', ''),
(11, 0, 0, 'Maul', '', 0, '', '', '0000-00-00', '', 0, 0, '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `subkriteria`
--

CREATE TABLE `subkriteria` (
  `kdSubKriteria` int(11) NOT NULL,
  `subKriteria` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  `kdKriteria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `subkriteria`
--

INSERT INTO `subkriteria` (`kdSubKriteria`, `subKriteria`, `value`, `kdKriteria`) VALUES
(1, 'Buruk Sekali', 1, 3),
(2, 'Buruk', 2, 3),
(3, 'Cukup', 3, 3),
(4, 'Baik', 4, 3),
(5, 'Baik Sekali', 5, 3),
(11, 'Buruk Sekali', 1, 5),
(12, 'Buruk', 2, 5),
(13, 'Cukup', 3, 5),
(14, 'Baik', 4, 5),
(15, 'Baik Sekali', 5, 5),
(16, 'Buruk Sekali', 1, 6),
(17, 'Buruk', 2, 6),
(18, 'Cukup', 3, 6),
(19, 'Baik', 4, 6),
(20, 'Baik Sekali', 5, 6),
(21, 'Buruk Sekali', 1, 7),
(22, 'Buruk', 2, 7),
(23, 'Cukup', 3, 7),
(24, 'Baik', 4, 7),
(25, 'Baik Sekali', 5, 7),
(26, 'Buruk Sekali', 1, 8),
(27, 'Buruk', 2, 8),
(28, 'Cukup', 3, 8),
(29, 'Baik', 4, 8),
(30, 'Baik Sekali', 5, 8);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(64) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `last_login` timestamp NOT NULL DEFAULT current_timestamp(),
  `photo` varchar(64) NOT NULL DEFAULT 'user_no_image.jpg',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `full_name`, `phone`, `role`, `last_login`, `photo`, `created_at`, `is_active`) VALUES
(1, 'resitapermata', '123', 'resitapermatasacn@gmail.com', 'Resita Permatasari Ayu Cahya Ningtyas', '08563600851', 'admin', '2023-03-07 16:55:24', 'user_no_image.jpg', '2021-04-15 01:47:32', 0),
(2, 'kepdes', '111', 'kepaladesa@gmail.com', 'kepala desa krisik', '081234234234', 'customer', '2023-03-01 12:16:56', 'user_no_image.jpg', '2021-04-18 13:13:51', 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dusun`
--
ALTER TABLE `dusun`
  ADD PRIMARY KEY (`kdDusun`);

--
-- Indeks untuk tabel `kriteria`
--
ALTER TABLE `kriteria`
  ADD PRIMARY KEY (`kdKriteria`);

--
-- Indeks untuk tabel `nilai`
--
ALTER TABLE `nilai`
  ADD UNIQUE KEY `indexNilai` (`kdPenerima`,`kdKriteria`) USING BTREE,
  ADD KEY `kdKriteria` (`kdKriteria`);

--
-- Indeks untuk tabel `penerima`
--
ALTER TABLE `penerima`
  ADD PRIMARY KEY (`kdPenerima`),
  ADD KEY `kdDusun` (`kdDusun`),
  ADD KEY `id_user` (`user_id`);

--
-- Indeks untuk tabel `subkriteria`
--
ALTER TABLE `subkriteria`
  ADD PRIMARY KEY (`kdSubKriteria`),
  ADD KEY `kdKriteria` (`kdKriteria`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `dusun`
--
ALTER TABLE `dusun`
  MODIFY `kdDusun` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kriteria`
--
ALTER TABLE `kriteria`
  MODIFY `kdKriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `penerima`
--
ALTER TABLE `penerima`
  MODIFY `kdPenerima` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `subkriteria`
--
ALTER TABLE `subkriteria`
  MODIFY `kdSubKriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `dusun`
--
ALTER TABLE `dusun`
  ADD CONSTRAINT `dusun_ibfk_1` FOREIGN KEY (`kdDusun`) REFERENCES `penerima` (`kdDusun`);

--
-- Ketidakleluasaan untuk tabel `nilai`
--
ALTER TABLE `nilai`
  ADD CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`kdPenerima`) REFERENCES `penerima` (`kdPenerima`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`kdKriteria`) REFERENCES `kriteria` (`kdKriteria`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `subkriteria`
--
ALTER TABLE `subkriteria`
  ADD CONSTRAINT `subkriteria_ibfk_1` FOREIGN KEY (`kdKriteria`) REFERENCES `kriteria` (`kdKriteria`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
