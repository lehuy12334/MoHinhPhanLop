-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 06, 2021 lúc 09:51 AM
-- Phiên bản máy phục vụ: 10.4.11-MariaDB
-- Phiên bản PHP: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `restaurant`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`id`, `phoneNumber`, `name`, `address`, `birthday`) VALUES
(1, '0911175581', 'Nguyễn Quốc Khánh', 'Nghệ An', '2000-04-09 10:00:00'),
(2, '0911175581', 'Nguyễn Văn Thành', 'Thành phố Hồ Chí Minh', '2000-09-16 10:00:00'),
(10, '0966144011', 'Trần Quốc Huy', '76/109 Bạch Đằng', '2000-12-01 22:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `startDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `permission` varchar(50) NOT NULL COMMENT 'manager-quản lý\r\nstaff-nhân viên\r\ninactive-nghỉ việc',
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`id`, `username`, `password`, `name`, `phoneNumber`, `startDate`, `permission`, `salary`) VALUES
(1, 'admin', 'admin', 'Admin', '0911175581', '2020-11-23 17:00:00', 'manager', 10600000),
(2, 'nhanvien', '2', 'Tea', '0911175581', '2020-11-24 05:15:08', 'staff', 0),
(5, 'huy1', '1', 'Huy1', '0911175582', '2020-12-16 14:11:54', 'manager', 0),
(6, 'khanh', '1', 'Nguyễn Quốc Khánh', '0958745164', '2020-12-16 14:21:20', 'manager', 0),
(7, 'thanh', '1', 'Nguyễn Văn Thành', '0869574153', '2020-12-16 14:22:12', 'manager', 0),
(27, 'karma', '1', 'text', '0968245175', '2020-12-23 16:52:39', 'staff', 0),
(30, 'huy', 'huy', 'Trần Quốc Huy', '0966144011', '2021-11-29 05:35:04', 'manager', 5000000),
(31, 'huy2', '14232', 'Trần Quốc Huy', '096457842', '2021-12-06 06:47:51', 'staff', 50000000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `food_category`
--

CREATE TABLE `food_category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `food_category`
--

INSERT INTO `food_category` (`id`, `name`, `slug`) VALUES
(1, 'Đồ Ăn', 'do-an'),
(2, 'Trà Sữa', 'tra-sua'),
(3, 'Cà Phê', 'ca-phe'),
(4, 'Topping', 'topping'),
(5, 'Kem', 'kem');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `food_item`
--

CREATE TABLE `food_item` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `urlImage` varchar(50) DEFAULT NULL,
  `unitName` varchar(20) NOT NULL,
  `unitPrice` bigint(20) NOT NULL,
  `idCategory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `food_item`
--

INSERT INTO `food_item` (`id`, `name`, `description`, `urlImage`, `unitName`, `unitPrice`, `idCategory`) VALUES
(1, 'No Topping', '', '', 'Phần', 0, 4),
(2, 'Trân Châu Tuyết Sợi', NULL, NULL, 'Phần', 10000, 4),
(3, 'Trân Châu Đen', NULL, NULL, 'Phần', 10000, 4),
(4, 'Trân Châu Trắng', NULL, NULL, 'Phần', 10000, 4),
(5, 'Trà Sữa Trân Châu', '', 'tra-sua-tran-chau-2020-12-23-08-54-16.png', 'Ly', 50000, 2),
(6, 'Trà Sữa Sương Sáo', NULL, NULL, 'Ly', 45000, 2),
(7, 'Trà Sữa Matcha(L)', '', '', 'Ly', 50000, 2),
(8, 'Sữa Tươi Trân Châu Đường Đen', NULL, NULL, 'Ly', 45000, 2),
(9, 'Bánh Flan', '', '', 'Cái', 10000, 1),
(10, 'Hướng dương', NULL, NULL, 'Túi', 10000, 1),
(11, 'Cafe truyền thống', NULL, NULL, 'Cốc', 35000, 3),
(12, 'Espresso', NULL, NULL, 'Cốc', 45000, 3),
(13, 'Trà Sữa Matcha(XL)', NULL, NULL, 'Ly', 25000, 2),
(14, 'Trà Sữa Ô Long', '', '', 'Ly', 20000, 2),
(15, 'Trà Đào', '', 'tra-ao-2020-12-23-08-54-25.png', 'Ly', 40000, 2),
(16, 'Trà Đào(L)', '', 'tra-ao-l-2020-12-23-08-54-33.png', 'Ly', 50000, 2),
(18, 'Trà Nhãn - Sen', '', 'tra-nhan---sen-2020-12-23-08-53-58.png', 'Ly', 45000, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `idTable` int(11) DEFAULT NULL,
  `type` varchar(45) NOT NULL DEFAULT 'local' COMMENT 'local - tại quán\nonline - đặt online',
  `status` varchar(45) NOT NULL DEFAULT 'unpaid' COMMENT 'unpaid - chưa thanh toán\npaid - đã thanh toán',
  `orderDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `payDate` timestamp NULL DEFAULT NULL,
  `paidAmount` bigint(20) DEFAULT 0,
  `totalAmount` bigint(20) NOT NULL DEFAULT 0,
  `discount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `order`
--

INSERT INTO `order` (`id`, `idEmployee`, `idTable`, `type`, `status`, `orderDate`, `payDate`, `paidAmount`, `totalAmount`, `discount`) VALUES
(1, 1, 1, 'local', 'paid', '2021-11-24 07:28:41', '2021-12-01 10:40:46', 450000, 450000, 0),
(2, 1, 1, 'online', 'paid', '2021-11-24 08:05:08', '2021-12-23 06:33:51', 406000, 406000, 0),
(3, 1, 3, 'local', 'paid', '2021-12-01 08:55:36', '2021-12-01 06:34:01', 550000, 550000, 5),
(8, 1, 5, 'local', 'paid', '2021-12-01 02:41:01', '2021-11-30 19:41:37', 95000, 95000, 0),
(11, 2, 1, 'online', 'paid', '2021-12-01 06:58:16', '2021-11-30 23:59:58', 0, 0, 0),
(12, 1, 1, 'online', 'paid', '2021-12-01 06:58:23', '2021-12-01 09:11:53', 7555555, 75000, 0),
(13, 1, 1, 'online', 'paid', '2021-12-02 06:58:28', NULL, 365000, 365000, 0),
(15, 1, 11, 'local', 'paid', '2021-11-01 02:14:30', '2021-11-01 12:59:41', 521250, 695000, 25),
(16, 7, 3, 'online', 'paid', '2021-11-02 15:13:30', '2021-11-02 18:21:15', 669700, 905000, 26),
(17, 5, 5, 'local', 'paid', '2021-11-05 17:54:05', '2021-11-06 00:42:49', 569400, 730000, 22),
(18, 27, 11, 'local', 'paid', '2021-11-08 17:11:40', '2021-11-09 01:25:39', 1686250, 1775000, 5),
(19, 27, 3, 'local', 'paid', '2021-11-02 07:06:30', '2021-11-02 16:31:15', 567450, 585000, 3),
(20, 7, 8, 'local', 'paid', '2021-11-08 19:50:09', '2021-11-08 20:13:59', 610500, 825000, 26),
(21, 1, 4, 'local', 'paid', '2021-11-23 09:26:40', '2021-11-23 14:27:37', 388800, 540000, 28),
(22, 1, 10, 'online', 'paid', '2021-11-09 21:24:21', '2021-11-10 07:18:55', 1345900, 1565000, 14),
(23, 5, 10, 'local', 'paid', '2021-11-04 20:17:08', '2021-11-05 01:39:10', 786600, 1035000, 24),
(24, 6, 15, 'local', 'paid', '2021-11-25 02:41:36', '2021-11-25 04:31:37', 423750, 565000, 25),
(25, 6, 5, 'local', 'paid', '2021-11-21 06:03:00', '2021-11-21 07:41:33', 592900, 770000, 23),
(26, 2, 11, 'local', 'paid', '2021-11-30 23:31:08', '2021-12-01 02:52:21', 55200, 60000, 8),
(27, 6, 15, 'online', 'paid', '2021-11-04 03:03:06', '2021-11-04 04:54:38', 847400, 1115000, 24),
(28, 27, 2, 'local', 'paid', '2021-12-03 08:36:06', '2021-12-03 16:45:35', 943950, 1085000, 13),
(29, 6, 4, 'local', 'paid', '2021-12-02 03:58:53', '2021-12-02 08:06:09', 783900, 1005000, 22),
(30, 27, 10, 'local', 'paid', '2021-12-02 08:37:50', '2021-12-02 15:12:26', 165000, 165000, 0),
(31, 1, 1, 'local', 'paid', '2021-11-26 10:58:11', '2021-11-26 16:41:37', 1552000, 1600000, 3),
(32, 2, 4, 'local', 'paid', '2021-11-22 00:00:10', '2021-11-22 11:30:26', 843750, 1125000, 25),
(33, 6, 7, 'online', 'paid', '2021-11-25 22:56:52', '2021-11-26 05:23:57', 40050, 45000, 11),
(34, 2, 4, 'local', 'paid', '2021-11-30 12:41:49', '2021-11-30 14:53:10', 922500, 1230000, 25),
(35, 1, 1, 'local', 'paid', '2021-11-29 05:11:08', '2021-11-28 22:12:16', 60000, 60000, 0),
(37, 1, 1, 'online', 'paid', '2021-11-29 05:29:15', '2021-11-28 22:44:48', 100000, 30000, 0),
(38, 1, 1, 'local', 'unpaid', '2021-12-03 14:31:06', NULL, 0, 0, 0),
(39, 1, 2, 'online', 'unpaid', '2021-12-03 14:31:15', NULL, 0, 0, 0),
(40, 2, 5, 'local', 'paid', '2021-12-03 14:40:10', '2021-12-03 07:41:26', 50000000, 60000, 0),
(41, 1, 4, 'local', 'paid', '2021-12-06 06:48:59', '2021-12-05 23:49:55', 222000, 220000, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_item`
--

CREATE TABLE `order_item` (
  `idOrder` int(11) NOT NULL,
  `idFoodItem` int(11) NOT NULL,
  `idTopping` int(11) NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `foodPrice` bigint(20) NOT NULL DEFAULT 0,
  `toppingPrice` bigint(20) NOT NULL DEFAULT 0,
  `note` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `order_item`
--

INSERT INTO `order_item` (`idOrder`, `idFoodItem`, `idTopping`, `quantity`, `foodPrice`, `toppingPrice`, `note`) VALUES
(1, 7, 1, 1, 50000, 0, NULL),
(1, 16, 1, 8, 50000, 0, ''),
(2, 8, 1, 2, 43000, 0, ''),
(2, 15, 1, 6, 40000, 0, ''),
(3, 5, 4, 5, 40000, 10000, ''),
(3, 15, 3, 10, 30000, 0, ''),
(8, 5, 1, 1, 50000, 0, ''),
(8, 6, 1, 1, 45000, 0, ''),
(12, 7, 1, 1, 50000, 0, ''),
(12, 13, 1, 1, 25000, 0, ''),
(13, 6, 2, 3, 45000, 10000, ''),
(13, 9, 1, 5, 10000, 0, ''),
(13, 10, 1, 4, 10000, 0, ''),
(13, 18, 3, 2, 45000, 10000, ''),
(15, 5, 1, 1, 50000, 0, ''),
(15, 6, 4, 2, 45000, 10000, ''),
(15, 11, 1, 5, 35000, 0, ''),
(15, 18, 1, 8, 45000, 0, ''),
(16, 7, 1, 9, 50000, 0, ''),
(16, 7, 4, 1, 50000, 10000, ''),
(16, 11, 1, 6, 35000, 0, ''),
(16, 12, 1, 1, 45000, 0, ''),
(16, 13, 4, 4, 25000, 10000, ''),
(17, 8, 2, 8, 45000, 10000, ''),
(17, 15, 4, 4, 40000, 10000, ''),
(17, 18, 1, 2, 45000, 0, ''),
(18, 5, 1, 11, 50000, 0, ''),
(18, 6, 2, 6, 45000, 10000, ''),
(18, 6, 4, 6, 45000, 10000, ''),
(18, 9, 1, 4, 10000, 0, ''),
(18, 11, 1, 2, 35000, 0, ''),
(18, 12, 1, 3, 45000, 0, ''),
(18, 13, 1, 4, 25000, 0, ''),
(18, 18, 4, 4, 45000, 10000, ''),
(19, 5, 1, 8, 50000, 0, ''),
(19, 9, 1, 2, 10000, 0, ''),
(19, 18, 2, 3, 45000, 10000, ''),
(20, 7, 1, 7, 50000, 0, ''),
(20, 8, 2, 1, 45000, 10000, ''),
(20, 11, 1, 12, 35000, 0, ''),
(21, 7, 2, 2, 50000, 10000, ''),
(21, 16, 2, 7, 50000, 10000, ''),
(22, 6, 2, 2, 45000, 10000, ''),
(22, 10, 1, 3, 10000, 0, ''),
(22, 12, 1, 9, 45000, 0, ''),
(22, 15, 1, 3, 40000, 0, ''),
(22, 16, 2, 8, 50000, 10000, ''),
(22, 16, 3, 7, 50000, 10000, ''),
(23, 5, 1, 4, 50000, 0, ''),
(23, 15, 2, 3, 40000, 10000, ''),
(23, 16, 4, 5, 50000, 10000, ''),
(23, 18, 4, 7, 45000, 10000, ''),
(24, 8, 1, 9, 45000, 0, ''),
(24, 8, 3, 1, 45000, 10000, ''),
(24, 11, 1, 3, 35000, 0, ''),
(25, 5, 3, 2, 50000, 10000, ''),
(25, 6, 4, 8, 45000, 10000, ''),
(25, 9, 1, 6, 10000, 0, ''),
(25, 14, 2, 5, 20000, 10000, ''),
(26, 10, 1, 6, 10000, 0, ''),
(27, 5, 4, 9, 50000, 10000, ''),
(27, 12, 1, 5, 45000, 0, ''),
(27, 13, 2, 1, 25000, 10000, ''),
(27, 13, 3, 5, 25000, 10000, ''),
(27, 14, 1, 7, 20000, 0, ''),
(28, 6, 4, 3, 45000, 10000, ''),
(28, 9, 1, 23, 10000, 0, ''),
(28, 11, 1, 7, 35000, 0, ''),
(28, 13, 1, 1, 25000, 0, ''),
(28, 16, 2, 1, 50000, 10000, ''),
(28, 18, 1, 8, 45000, 0, ''),
(29, 5, 1, 6, 50000, 0, ''),
(29, 7, 1, 7, 50000, 0, ''),
(29, 10, 1, 7, 10000, 0, ''),
(29, 12, 1, 3, 45000, 0, ''),
(29, 13, 1, 6, 25000, 0, ''),
(30, 5, 3, 2, 50000, 10000, ''),
(30, 12, 1, 1, 45000, 0, ''),
(31, 5, 3, 9, 50000, 10000, ''),
(31, 9, 1, 2, 10000, 0, ''),
(31, 12, 1, 2, 45000, 0, ''),
(31, 13, 3, 5, 25000, 10000, ''),
(31, 15, 1, 4, 40000, 0, ''),
(31, 15, 3, 6, 40000, 10000, ''),
(31, 18, 1, 7, 45000, 0, ''),
(32, 5, 1, 6, 50000, 0, ''),
(32, 7, 3, 6, 50000, 10000, ''),
(32, 9, 1, 6, 10000, 0, ''),
(32, 10, 1, 2, 10000, 0, ''),
(32, 13, 3, 4, 25000, 10000, ''),
(32, 13, 4, 7, 25000, 10000, ''),
(33, 6, 1, 1, 45000, 0, ''),
(34, 10, 1, 9, 10000, 0, ''),
(34, 12, 1, 2, 45000, 0, ''),
(34, 14, 4, 1, 20000, 10000, ''),
(34, 16, 2, 10, 50000, 10000, ''),
(34, 16, 3, 7, 50000, 10000, ''),
(35, 2, 1, 1, 10000, 0, ''),
(35, 5, 1, 1, 50000, 0, ''),
(37, 9, 1, 1, 10000, 0, ''),
(37, 14, 1, 1, 20000, 0, ''),
(40, 3, 1, 1, 10000, 0, ''),
(40, 7, 1, 1, 50000, 0, ''),
(41, 5, 1, 1, 50000, 0, ''),
(41, 8, 1, 3, 45000, 0, ''),
(41, 13, 2, 1, 25000, 10000, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `endTime` timestamp NULL DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `session`
--

INSERT INTO `session` (`id`, `idEmployee`, `startTime`, `endTime`, `message`) VALUES
(20, 1, '2020-12-26 05:58:09', '2020-12-26 05:58:15', 'logout'),
(21, 2, '2020-12-26 10:21:50', '2020-12-26 10:22:06', 'logout'),
(23, 2, '2020-12-26 10:22:59', '2020-12-26 12:13:20', 'logout'),
(24, 1, '2020-12-26 15:46:25', '2020-12-26 15:47:22', 'logout'),
(25, 1, '2020-12-27 05:46:33', '2020-12-27 06:53:14', 'logout'),
(26, 1, '2020-12-27 06:55:49', '2020-12-27 07:25:30', 'logout'),
(27, 1, '2020-12-27 07:25:37', '2020-12-27 09:37:44', 'logout'),
(28, 1, '2020-12-27 09:39:08', '2020-12-27 09:51:08', 'logout'),
(30, 1, '2020-12-27 15:13:40', '2020-12-27 15:13:51', 'logout'),
(31, 1, '2020-12-27 15:14:33', '2020-12-27 15:15:08', 'logout'),
(32, 1, '2020-12-27 15:15:23', '2020-12-27 15:15:32', 'logout'),
(33, 1, '2020-12-27 15:18:00', '2020-12-27 15:18:05', 'logout'),
(34, 1, '2020-12-27 15:19:20', '2020-12-27 15:19:25', 'logout'),
(35, 1, '2020-12-28 15:30:20', '2020-12-28 15:31:00', 'logout'),
(36, 1, '2020-12-28 15:35:36', '2020-12-28 15:36:39', 'logout'),
(37, 1, '2020-12-28 15:36:53', '2020-12-28 15:37:03', 'logout'),
(38, 1, '2020-12-28 16:10:47', '2020-12-28 16:17:10', 'logout'),
(39, 1, '2020-12-28 16:20:28', '2020-12-28 16:21:11', 'logout'),
(40, 1, '2020-12-28 16:21:43', '2020-12-28 16:21:58', 'logout'),
(41, 1, '2020-12-28 16:22:09', '2020-12-28 16:22:20', 'logout'),
(42, 1, '2020-12-28 16:22:31', '2020-12-28 16:22:53', 'logout'),
(43, 1, '2020-12-28 16:23:04', '2020-12-28 16:23:17', 'logout'),
(44, 1, '2020-12-28 16:23:27', NULL, 'login'),
(45, 1, '2020-12-28 16:37:35', '2020-12-28 16:37:47', 'logout'),
(46, 1, '2020-12-28 16:39:34', '2020-12-28 16:39:53', 'logout'),
(47, 1, '2020-12-28 16:40:02', '2020-12-28 16:40:14', 'logout'),
(48, 1, '2020-12-29 07:17:33', '2020-12-29 07:17:42', 'logout'),
(49, 1, '2020-12-29 07:18:06', '2020-12-29 07:18:14', 'logout'),
(50, 1, '2020-12-29 07:18:23', '2020-12-29 07:18:28', 'logout'),
(51, 1, '2020-12-29 07:18:37', '2020-12-29 07:18:44', 'logout'),
(52, 1, '2020-12-29 07:18:54', '2020-12-29 07:19:00', 'logout'),
(53, 1, '2020-12-29 07:19:12', '2020-12-29 07:19:18', 'logout'),
(54, 1, '2020-12-29 07:19:33', '2020-12-29 07:19:38', 'logout'),
(55, 1, '2021-01-09 03:42:06', NULL, 'login'),
(56, 1, '2021-01-10 14:17:16', '2021-01-10 14:17:42', 'logout'),
(57, 1, '2021-01-10 14:20:51', '2021-01-10 14:21:12', 'logout'),
(58, 1, '2021-11-29 03:57:03', NULL, 'login'),
(59, 1, '2021-11-28 22:01:35', '2021-11-28 22:01:44', 'logout'),
(60, 2, '2021-11-28 22:01:48', '2021-11-28 22:01:53', 'logout'),
(61, 1, '2021-11-28 22:02:00', '2021-11-28 22:41:32', 'logout'),
(62, 30, '2021-11-28 22:41:35', '2021-11-28 22:41:50', 'logout'),
(63, 2, '2021-11-28 22:42:02', '2021-11-28 22:42:12', 'logout'),
(64, 1, '2021-11-28 22:42:14', '2021-11-28 22:42:18', 'logout'),
(65, 30, '2021-11-28 22:42:23', NULL, 'login'),
(66, 1, '2021-12-03 07:03:05', '2021-12-03 07:07:45', 'logout'),
(67, 6, '2021-12-03 07:09:33', '2021-12-03 07:11:57', 'logout'),
(68, 1, '2021-12-03 07:11:59', '2021-12-03 07:29:59', 'logout'),
(69, 1, '2021-12-03 07:30:01', '2021-12-03 07:37:28', 'logout'),
(70, 5, '2021-12-03 07:37:52', '2021-12-03 07:38:29', 'logout'),
(71, 2, '2021-12-03 07:38:32', '2021-12-03 07:38:36', 'logout'),
(72, 1, '2021-12-03 07:38:38', '2021-12-03 07:38:42', 'logout'),
(73, 2, '2021-12-03 07:38:44', '2021-12-03 07:44:17', 'logout'),
(74, 1, '2021-12-03 07:44:19', '2021-12-03 08:03:02', 'logout'),
(75, 5, '2021-12-05 03:09:03', '2021-12-05 03:10:02', 'logout'),
(76, 1, '2021-12-05 03:27:41', '2021-12-05 03:37:03', 'logout'),
(77, 1, '2021-12-05 03:45:47', '2021-12-05 03:45:59', 'logout'),
(78, 1, '2021-12-05 06:14:11', '2021-12-05 06:14:34', 'logout'),
(79, 1, '2021-12-05 06:15:38', '2021-12-05 06:15:59', 'logout'),
(80, 1, '2021-12-05 06:25:25', '2021-12-05 06:30:11', 'logout'),
(81, 1, '2021-12-05 06:30:21', '2021-12-05 06:30:24', 'logout'),
(82, 1, '2021-12-05 06:36:04', '2021-12-05 06:37:42', 'logout'),
(83, 1, '2021-12-05 06:42:24', '2021-12-05 06:42:34', 'logout'),
(84, 1, '2021-12-05 06:47:55', '2021-12-05 06:47:59', 'logout'),
(85, 1, '2021-12-05 06:49:00', '2021-12-05 06:54:41', 'logout'),
(86, 1, '2021-12-05 06:54:51', '2021-12-05 06:56:19', 'logout'),
(87, 1, '2021-12-05 22:53:53', '2021-12-05 22:54:04', 'logout'),
(88, 1, '2021-12-05 22:54:22', '2021-12-05 22:55:52', 'logout'),
(89, 1, '2021-12-05 23:21:37', '2021-12-05 23:36:45', 'logout'),
(90, 1, '2021-12-05 23:38:32', '2021-12-05 23:47:03', 'logout'),
(91, 1, '2021-12-05 23:47:21', '2021-12-05 23:57:31', 'logout');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shipment`
--

CREATE TABLE `shipment` (
  `idOrder` int(11) NOT NULL,
  `idCustomer` int(11) NOT NULL,
  `shipperName` varchar(50) NOT NULL,
  `shipperPhoneNumber` varchar(20) NOT NULL,
  `shipCost` int(11) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'topay' COMMENT 'topay - chờ xác nhận\ntoship - chờ lấy hàng\ntoreceive - đang giao\ncompleted - hoàn thành\ncancelled - đã hủy',
  `notice` varchar(45) DEFAULT NULL,
  `startDate` timestamp NULL DEFAULT current_timestamp(),
  `endDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `shipment`
--

INSERT INTO `shipment` (`idOrder`, `idCustomer`, `shipperName`, `shipperPhoneNumber`, `shipCost`, `status`, `notice`, `startDate`, `endDate`) VALUES
(2, 10, 'Nguyễn Văn B', '09421321323', 0, 'completed', NULL, '2020-11-23 17:00:00', '2021-11-28 22:41:17'),
(11, 1, 'Nguyễn Văn B', '09421321323', 0, 'toreceive', NULL, '2020-12-25 06:58:48', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `table`
--

CREATE TABLE `table` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'free' COMMENT 'free-Trống\nserving-Đang phục vụ\nreserving-Đặt trước'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `table`
--

INSERT INTO `table` (`id`, `name`, `status`) VALUES
(1, 'Bàn 1', 'free'),
(2, 'Bàn 2', 'free'),
(3, 'Bàn 3', 'free'),
(4, 'Bàn 4', 'free'),
(5, 'Bàn 5', 'free'),
(6, 'Bàn 6', 'free'),
(7, 'Bàn 7', 'free'),
(8, 'Bàn 8', 'free'),
(10, 'Bàn 10', 'free'),
(11, 'Bàn 11', 'free'),
(15, 'Bàn 12', 'free'),
(16, 'BÀN CHỜ MANG ĐI', 'free');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Chỉ mục cho bảng `food_category`
--
ALTER TABLE `food_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `food_item`
--
ALTER TABLE `food_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `fk_item_category` (`idCategory`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_employee_order` (`idEmployee`),
  ADD KEY `fk_order_table` (`idTable`);

--
-- Chỉ mục cho bảng `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`idOrder`,`idFoodItem`,`idTopping`),
  ADD KEY `fk_order_main_item` (`idFoodItem`),
  ADD KEY `fk_order_topping` (`idTopping`);

--
-- Chỉ mục cho bảng `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_session` (`idEmployee`);

--
-- Chỉ mục cho bảng `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`idOrder`),
  ADD KEY `fk_ship_customer` (`idCustomer`);

--
-- Chỉ mục cho bảng `table`
--
ALTER TABLE `table`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `food_category`
--
ALTER TABLE `food_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `food_item`
--
ALTER TABLE `food_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT cho bảng `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT cho bảng `table`
--
ALTER TABLE `table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `food_item`
--
ALTER TABLE `food_item`
  ADD CONSTRAINT `fk_item_category` FOREIGN KEY (`idCategory`) REFERENCES `food_category` (`id`);

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_employee_order` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `fk_order_table` FOREIGN KEY (`idTable`) REFERENCES `table` (`id`);

--
-- Các ràng buộc cho bảng `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `fk_order_item` FOREIGN KEY (`idOrder`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `fk_order_main_item` FOREIGN KEY (`idFoodItem`) REFERENCES `food_item` (`id`),
  ADD CONSTRAINT `fk_order_topping` FOREIGN KEY (`idTopping`) REFERENCES `food_item` (`id`);

--
-- Các ràng buộc cho bảng `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `fk_session` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `shipment`
--
ALTER TABLE `shipment`
  ADD CONSTRAINT `fk_order_ship` FOREIGN KEY (`idOrder`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `fk_ship_customer` FOREIGN KEY (`idCustomer`) REFERENCES `customer` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
