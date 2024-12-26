-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for hospital
CREATE DATABASE IF NOT EXISTS `hospital` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hospital`;

-- Dumping structure for table hospital.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.admin: ~1 rows (approximately)
DELETE FROM `admin`;
INSERT INTO `admin` (`id`, `username`, `password`) VALUES
	(1, 'admin', '21232f297a57a5a743894a0e4a801fc3');

-- Dumping structure for table hospital.daftar_poli
CREATE TABLE IF NOT EXISTS `daftar_poli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pasien` int NOT NULL,
  `id_jadwal` int NOT NULL,
  `keluhan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_antrian` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id_pasien` (`id_pasien`) USING BTREE,
  KEY `id_jadwal` (`id_jadwal`) USING BTREE,
  CONSTRAINT `daftar_poli_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `daftar_poli_ibfk_2` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal_periksa` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.daftar_poli: ~2 rows (approximately)
DELETE FROM `daftar_poli`;
INSERT INTO `daftar_poli` (`id`, `id_pasien`, `id_jadwal`, `keluhan`, `no_antrian`) VALUES
	(1, 1, 1, 'Demam dan pusing', 1),
	(2, 2, 3, 'Sakit gigi', 1),
	(3, 3, 5, 'Mata berair', 1),
	(4, 4, 6, 'Batuk pilek', 1),
	(29, 19, 1, 'sakit parah', 2),
	(30, 21, 2, 'test', 1);

-- Dumping structure for table hospital.detail_periksa
CREATE TABLE IF NOT EXISTS `detail_periksa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_periksa` int NOT NULL,
  `id_obat` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id_periksa` (`id_periksa`) USING BTREE,
  KEY `id_obat` (`id_obat`) USING BTREE,
  CONSTRAINT `detail_periksa_ibfk_1` FOREIGN KEY (`id_periksa`) REFERENCES `periksa` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `detail_periksa_ibfk_2` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.detail_periksa: ~8 rows (approximately)
DELETE FROM `detail_periksa`;
INSERT INTO `detail_periksa` (`id`, `id_periksa`, `id_obat`) VALUES
	(30, 1, 1),
	(31, 1, 4),
	(32, 2, 2),
	(33, 3, 4),
	(34, 4, 2),
	(35, 4, 4),
	(36, 36, 2),
	(37, 36, 1);

-- Dumping structure for table hospital.dokter
CREATE TABLE IF NOT EXISTS `dokter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `no_hp` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_poli` int NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id_poli` (`id_poli`) USING BTREE,
  CONSTRAINT `dokter_ibfk_1` FOREIGN KEY (`id_poli`) REFERENCES `poli` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.dokter: ~4 rows (approximately)
DELETE FROM `dokter`;
INSERT INTO `dokter` (`id`, `nama`, `alamat`, `no_hp`, `id_poli`, `password`, `deleted_at`) VALUES
	(1, 'Dr. Andika Pratama', 'Jl. Mangga No. 10', '08123456789', 1, 'dokter123', NULL),
	(2, 'Dr. Sinta Dewi', 'Jl. Apel No. 15', '08234567890', 2, 'dokter123', '2024-12-25 05:10:56'),
	(3, 'Dr. Budi Santoso', 'Jl. Jeruk No. 20', '08345678901', 3, 'dokter123', NULL),
	(4, 'Dr. Maya Putri', 'Jl. Anggur No. 25', '08456789012', 4, 'dokter123', NULL);

-- Dumping structure for table hospital.jadwal_periksa
CREATE TABLE IF NOT EXISTS `jadwal_periksa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_dokter` int NOT NULL,
  `hari` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id_dokter` (`id_dokter`) USING BTREE,
  CONSTRAINT `jadwal_periksa_ibfk_1` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.jadwal_periksa: ~7 rows (approximately)
DELETE FROM `jadwal_periksa`;
INSERT INTO `jadwal_periksa` (`id`, `id_dokter`, `hari`, `jam_mulai`, `jam_selesai`, `status`, `deleted_at`) VALUES
	(1, 1, 'Senin', '08:00:00', '16:00:00', 0, NULL),
	(2, 1, 'Rabu', '08:00:00', '16:00:00', 1, NULL),
	(3, 2, 'Selasa', '09:00:00', '17:00:00', 1, NULL),
	(4, 2, 'Kamis', '09:00:00', '17:00:00', 0, NULL),
	(5, 3, 'Rabu', '10:00:00', '18:00:00', 1, NULL),
	(6, 4, 'Jumat', '08:00:00', '16:00:00', 1, NULL),
	(24, 1, 'Selasa', '18:24:00', '19:20:00', 0, '2024-12-25 05:32:02');

-- Dumping structure for table hospital.obat
CREATE TABLE IF NOT EXISTS `obat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_obat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kemasan` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `harga` int unsigned DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.obat: ~6 rows (approximately)
DELETE FROM `obat`;
INSERT INTO `obat` (`id`, `nama_obat`, `kemasan`, `harga`, `deleted_at`) VALUES
	(1, 'Paracetamol', 'Strip 10 Tablet', 12000, NULL),
	(2, 'Amoxicillin', 'Strip 8 Kapsul', 25000, NULL),
	(3, 'Omeprazole', 'Strip 6 Tablet', 35000, '2024-12-25 05:28:01'),
	(4, 'Vitamin C', 'Strip 12 Tablet', 15000, NULL),
	(5, 'Aspirin', 'Strip 10 Tablet', 12000, NULL),
	(16, 'Ibuprofen', 'Strip 10 Tablet', 18000, NULL);

-- Dumping structure for table hospital.pasien
CREATE TABLE IF NOT EXISTS `pasien` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_ktp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_hp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_rm` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.pasien: ~6 rows (approximately)
DELETE FROM `pasien`;
INSERT INTO `pasien` (`id`, `nama`, `alamat`, `no_ktp`, `no_hp`, `no_rm`, `deleted_at`) VALUES
	(1, 'Rudi Hermawan', 'Jl. Mawar No. 1', '3374123456789001', '081234567890', '202401-001', NULL),
	(2, 'Siti Aminah', 'Jl. Melati No. 2', '3374123456789002', '082345678901', '202401-002', NULL),
	(3, 'Joko Widodo', 'Jl. Kenanga No. 3', '3374123456789003', '083456789012', '202401-003', NULL),
	(4, 'Ani Susilowati', 'Jl. Dahlia No. 4', '3374123456789004', '084567890123', '202401-004', NULL),
	(19, 'Aditya Gilang Pangestu', 'Brebes', '12333', '085329727224', '202412-005', NULL),
	(20, 'Explicabo Consequat', 'Sed molestiae incidi', '12345678', '08918819819', '202412-006', '2024-12-25 05:13:02'),
	(21, 'Agus12', 'tset', '12312312312', '08123456789', '202412-007', NULL);

-- Dumping structure for table hospital.periksa
CREATE TABLE IF NOT EXISTS `periksa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_daftar_poli` int NOT NULL,
  `tgl_periksa` date NOT NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `biaya_periksa` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id_daftar_poli` (`id_daftar_poli`) USING BTREE,
  CONSTRAINT `periksa_ibfk_1` FOREIGN KEY (`id_daftar_poli`) REFERENCES `daftar_poli` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.periksa: ~5 rows (approximately)
DELETE FROM `periksa`;
INSERT INTO `periksa` (`id`, `id_daftar_poli`, `tgl_periksa`, `catatan`, `biaya_periksa`) VALUES
	(1, 1, '2024-01-08', 'Flu dan kecapekan', 165000),
	(2, 2, '2024-01-09', 'Gigi berlubang', 175000),
	(3, 3, '2024-01-10', 'Iritasi mata', 185000),
	(4, 4, '2024-01-12', 'ISPA', 170000),
	(36, 29, '2024-12-08', 'istirahat yaa', 187000);

-- Dumping structure for table hospital.poli
CREATE TABLE IF NOT EXISTS `poli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_poli` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table hospital.poli: ~4 rows (approximately)
DELETE FROM `poli`;
INSERT INTO `poli` (`id`, `nama_poli`, `keterangan`, `deleted_at`) VALUES
	(1, 'Poli Umum', 'Menangani masalah kesehatan umum', NULL),
	(2, 'Poli Gigi', 'Menangani masalah kesehatan gigi dan mulut', '2024-12-25 05:27:26'),
	(3, 'Poli Mata', 'Menangani masalah kesehatan mata', NULL),
	(4, 'Poli Anak', 'Menangani masalah kesehatan anak', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
