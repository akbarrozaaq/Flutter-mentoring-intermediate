-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Feb 2021 pada 12.03
-- Versi server: 10.4.13-MariaDB
-- Versi PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_week1intermediate`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_favorite`
--

CREATE TABLE `tb_favorite` (
  `favorite_id` varchar(256) NOT NULL,
  `favorite_email` varchar(256) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_favorite`
--

INSERT INTO `tb_favorite` (`favorite_id`, `favorite_email`, `status`) VALUES
('UExrNTd6SExLbG5UOEVZN0U1RF9qLTdIY2lUZGJuRjN0Ui4xMkVGQjNCMUM1N0RFNEUx', 'rozaaq@gmail.com', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_grafik`
--

CREATE TABLE `tb_grafik` (
  `grafik_id` int(11) NOT NULL,
  `grafik_jenjang` varchar(256) NOT NULL,
  `grafik_jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_grafik`
--

INSERT INTO `tb_grafik` (`grafik_id`, `grafik_jenjang`, `grafik_jumlah`) VALUES
(1, 'SD', 25203371),
(2, 'SMP', 10112022),
(3, 'SMA', 4976127),
(4, 'SMK', 5249149);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_user`
--

CREATE TABLE `tb_user` (
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(50) NOT NULL,
  `user_nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_user`
--

INSERT INTO `tb_user` (`user_email`, `user_password`, `user_nama`) VALUES
('rozaaq@gmail.com', '123456', 'Akbar Rozaaq');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_favorite`
--
ALTER TABLE `tb_favorite`
  ADD PRIMARY KEY (`favorite_id`),
  ADD KEY `favorite_email` (`favorite_email`);

--
-- Indeks untuk tabel `tb_grafik`
--
ALTER TABLE `tb_grafik`
  ADD PRIMARY KEY (`grafik_id`);

--
-- Indeks untuk tabel `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`user_email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_grafik`
--
ALTER TABLE `tb_grafik`
  MODIFY `grafik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tb_favorite`
--
ALTER TABLE `tb_favorite`
  ADD CONSTRAINT `tb_favorite_ibfk_1` FOREIGN KEY (`favorite_email`) REFERENCES `tb_user` (`user_email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
