-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2024 at 03:45 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uas`
--

-- --------------------------------------------------------

--
-- Table structure for table `gambar`
--

CREATE TABLE `gambar` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `ukuran` int(11) NOT NULL,
  `tipe` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `klub`
--

CREATE TABLE `klub` (
  `id` int(10) NOT NULL,
  `nama_klub` varchar(20) NOT NULL,
  `tgl_berdiri` date NOT NULL,
  `kondisi_klub` int(11) NOT NULL,
  `kota_klub` varchar(11) NOT NULL,
  `peringkat` varchar(10) NOT NULL,
  `harga_klub` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `klub`
--

INSERT INTO `klub` (`id`, `nama_klub`, `tgl_berdiri`, `kondisi_klub`, `kota_klub`, `peringkat`, `harga_klub`) VALUES
(2, 'FC Barcelona asasasa', '2024-01-14', 2, '1', '1-3', 900000000),
(3, 'Manchester United', '1878-04-05', 0, '4', '3', 800000000),
(4, 'Bayern Munich', '1900-02-27', 1, '3', '4', 700000000),
(5, 'Juventus', '1897-11-01', 2, '0', '5', 600000000),
(6, 'Paris Saint-Germain', '1970-08-12', 0, '2', '6', 500000000),
(7, 'Liverpool', '1892-06-03', 1, '1', '7', 400000000),
(8, 'AC Milan', '1899-12-16', 2, '4', '8', 300000000),
(9, 'Chelsea', '1905-03-10', 0, '3', '9', 200000000),
(10, 'Borussia Dortmund', '1909-12-19', 1, '5', '10', 100000000),
(11, 'Onananan', '2024-01-14', 0, '0', '1-3', 12366600),
(12, 'Onananan', '2024-01-14', 0, '0', '1-3', 12366600),
(13, 'Onananan', '2024-01-14', 0, 'Mahakan', '1-3', 12366600),
(15, 'alskalsas', '2024-01-14', 0, 'pqowpqowpo', '7-15', 1212121),
(16, 'alskalsasqwqwqwqw', '2024-01-14', 0, 'asasasasas', '4-6', 1212121);

-- --------------------------------------------------------

--
-- Table structure for table `supporter`
--

CREATE TABLE `supporter` (
  `id` int(10) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `tgl_daftar` date NOT NULL,
  `no_telpon` varchar(15) NOT NULL,
  `foto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supporter`
--

INSERT INTO `supporter` (`id`, `nama`, `alamat`, `tgl_daftar`, `no_telpon`, `foto`) VALUES
(4, 'Emily Davis', 'Jl. Dummy No. 321', '2024-01-17', '087654321098', ''),
(5, 'Robert White', 'Jl. Template No. 654', '2024-01-18', '089012345678', ''),
(6, 'Alice Brown', 'Jl. Example No. 987', '2024-01-19', '083210987654', ''),
(7, 'David Miller', 'Jl. Test No. 135', '2024-01-20', '086543210987', ''),
(9, 'William Turner', 'Jl. Demo No. 579', '2024-01-22', '088765432109', ''),
(10, 'Sophia Harris', 'Jl. Sample No. 864', '2024-01-23', '080987654321', ''),
(34, 'Nama .text', 'Alamat .text', '2024-01-19', '0812232323', 'IMG_20240114_200227.jpg'),
(39, 'buyanan hamka', 'olang aling', '2024-01-14', '01920129012', 'IMG_20240114_200227.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gambar`
--
ALTER TABLE `gambar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `klub`
--
ALTER TABLE `klub`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supporter`
--
ALTER TABLE `supporter`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gambar`
--
ALTER TABLE `gambar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `klub`
--
ALTER TABLE `klub`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `supporter`
--
ALTER TABLE `supporter`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
