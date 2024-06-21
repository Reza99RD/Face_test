-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 21, 2024 at 09:10 AM
-- Server version: 8.0.37-0ubuntu0.22.04.3
-- PHP Version: 8.1.2-1ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `face_recognition_attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `national_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `section` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `national_id`, `first_name`, `last_name`, `section`, `role`) VALUES
(1, '101', 'Reza', 'Aminzadeh', 'پژوهش', 'مدیر کل'),
(2, '102', 'Cristiano', 'Ronaldo', 'اداری', 'مدیر اداری'),
(3, '103', 'Mostafa', 'Moosavinia', 'مالی', 'مدیر کل'),
(4, '104', 'Leonardo', 'DiCaprio', 'HR', 'منابع انسانی'),
(5, '105', 'Masoud', 'Akbari', 'IT', 'IT مدیر'),
(6, '106', 'Lionel', 'Messi', 'پژوهش', '-'),
(7, '107', 'Shahab', 'Hosseini', 'HR', '-'),
(8, '108', 'Joe', 'Biden', 'IT', '-'),
(9, '109', 'Mohsen', 'Abbasi', 'مالی', 'مدیر مالی'),
(10, '110', 'Hamid', 'Mahmoodi', 'HR', '-'),
(11, '111', 'Mehran ', 'Modiri', 'اداری', 'نگهبانی'),
(13, '113', 'Amir', 'Dabiri', 'IT', '-'),
(15, '115', 'احمد', 'فرهادی', 'پژوهش', 'مدیر پژوهش'),
(21, '121', 'سهیل', 'اکبری', 'اداری', 'منابع انسانی');

-- --------------------------------------------------------

--
-- Stand-in structure for view `staff_attendance_view`
-- (See below for the actual view)
--
CREATE TABLE `staff_attendance_view` (
`staff_id` int
,`national_id` varchar(20)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`section` varchar(50)
,`date` date
,`enter_time` datetime
,`exit_time` datetime
,`attendance_hours` varchar(46)
,`deduction_of_attendance` varchar(48)
,`extra_attendance` varchar(47)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `staff_attendance_view_IT`
-- (See below for the actual view)
--
CREATE TABLE `staff_attendance_view_IT` (
`staff_id` int
,`national_id` varchar(20)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`section` varchar(50)
,`date` date
,`enter_time` datetime
,`exit_time` datetime
,`attendance_hours` varchar(46)
,`deduction_of_attendance` varchar(48)
,`extra_attendance` varchar(47)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `staff_attendance_view_اداری`
-- (See below for the actual view)
--
CREATE TABLE `staff_attendance_view_اداری` (
`staff_id` int
,`national_id` varchar(20)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`section` varchar(50)
,`date` date
,`enter_time` datetime
,`exit_time` datetime
,`attendance_hours` varchar(46)
,`deduction_of_attendance` varchar(48)
,`extra_attendance` varchar(47)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `staff_attendance_view_مالی`
-- (See below for the actual view)
--
CREATE TABLE `staff_attendance_view_مالی` (
`staff_id` int
,`national_id` varchar(20)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`section` varchar(50)
,`date` date
,`enter_time` datetime
,`exit_time` datetime
,`attendance_hours` varchar(46)
,`deduction_of_attendance` varchar(48)
,`extra_attendance` varchar(47)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `staff_attendance_view_پژوهش`
-- (See below for the actual view)
--
CREATE TABLE `staff_attendance_view_پژوهش` (
`staff_id` int
,`national_id` varchar(20)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`section` varchar(50)
,`date` date
,`enter_time` datetime
,`exit_time` datetime
,`attendance_hours` varchar(46)
,`deduction_of_attendance` varchar(48)
,`extra_attendance` varchar(47)
);

-- --------------------------------------------------------

--
-- Table structure for table `time_log`
--

CREATE TABLE `time_log` (
  `id` int NOT NULL,
  `staff_id` int NOT NULL,
  `log_time` datetime NOT NULL,
  `log_type` varchar(5) NOT NULL,
  `gate` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `time_log`
--

INSERT INTO `time_log` (`id`, `staff_id`, `log_time`, `log_type`, `gate`) VALUES
(371, 1, '1403-01-05 12:16:20', 'enter', 'Gate 1'),
(372, 1, '1403-01-05 12:18:13', 'enter', 'Gate 1'),
(373, 10, '1403-01-05 12:18:13', 'enter', 'Gate 1'),
(374, 1, '1403-01-05 12:18:24', 'enter', 'Gate 1'),
(375, 10, '1403-01-05 12:18:24', 'enter', 'Gate 1'),
(376, 5, '1403-01-05 12:18:35', 'enter', 'Gate 1'),
(377, 2, '1403-01-05 12:18:35', 'enter', 'Gate 1'),
(378, 1, '1403-01-05 12:18:35', 'enter', 'Gate 1'),
(379, 10, '1403-01-05 12:18:35', 'enter', 'Gate 1'),
(380, 10, '1403-01-05 12:18:47', 'enter', 'Gate 1'),
(381, 5, '1403-01-05 12:18:59', 'enter', 'Gate 1'),
(382, 2, '1403-01-05 12:18:59', 'enter', 'Gate 1'),
(383, 10, '1403-01-05 12:18:59', 'enter', 'Gate 1'),
(384, 5, '1403-01-05 12:19:11', 'enter', 'Gate 1'),
(385, 2, '1403-01-05 12:19:11', 'enter', 'Gate 1'),
(386, 10, '1403-01-05 12:19:11', 'enter', 'Gate 1'),
(387, 5, '1403-01-05 12:29:55', 'enter', 'Gate 1'),
(388, 10, '1403-01-05 12:29:55', 'enter', 'Gate 1'),
(389, 10, '1403-01-05 12:30:06', 'enter', 'Gate 1'),
(390, 10, '1403-01-05 12:31:23', 'enter', 'Gate 1'),
(391, 10, '1403-01-05 12:31:34', 'enter', 'Gate 1'),
(393, 10, '1403-01-05 12:31:56', 'enter', 'Gate 1'),
(395, 10, '1403-01-05 12:32:07', 'enter', 'Gate 1'),
(396, 10, '1403-01-05 12:32:18', 'enter', 'Gate 1'),
(397, 10, '1403-01-05 12:32:29', 'enter', 'Gate 1'),
(398, 10, '1403-01-05 12:34:03', 'enter', 'Gate 1'),
(400, 10, '1403-01-05 12:37:38', 'enter', 'Gate 1'),
(401, 10, '1403-01-05 12:37:49', 'enter', 'Gate 1'),
(402, 10, '1403-01-05 12:38:00', 'enter', 'Gate 1'),
(404, 10, '1403-01-05 12:38:11', 'enter', 'Gate 1'),
(405, 10, '1403-01-05 12:38:22', 'enter', 'Gate 1'),
(406, 10, '1403-01-05 12:38:33', 'enter', 'Gate 1'),
(407, 10, '1403-01-05 12:38:44', 'enter', 'Gate 1'),
(408, 10, '1403-01-05 12:38:55', 'enter', 'Gate 1'),
(410, 2, '1403-01-05 12:40:39', 'enter', 'Gate 1'),
(411, 2, '1403-01-05 12:41:16', 'enter', 'Gate 1'),
(412, 10, '1403-01-05 12:41:16', 'enter', 'Gate 1'),
(413, 2, '1403-01-05 12:41:53', 'enter', 'Gate 1'),
(414, 10, '1403-01-05 12:41:53', 'enter', 'Gate 1'),
(416, 7, '1403-01-05 12:42:29', 'enter', 'Gate 1'),
(417, 2, '1403-01-05 12:42:29', 'enter', 'Gate 1'),
(418, 10, '1403-01-05 12:42:29', 'enter', 'Gate 1'),
(419, 7, '1403-01-05 12:43:38', 'enter', 'Gate 1'),
(420, 2, '1403-01-05 12:43:38', 'enter', 'Gate 1'),
(421, 4, '1403-01-05 12:44:14', 'enter', 'Gate 1'),
(422, 7, '1403-01-05 12:44:14', 'enter', 'Gate 1'),
(423, 2, '1403-01-05 12:44:14', 'enter', 'Gate 1'),
(424, 1, '1403-01-05 12:44:14', 'enter', 'Gate 1'),
(425, 5, '1403-01-05 12:44:14', 'enter', 'Gate 1'),
(427, 2, '1403-01-05 12:44:50', 'enter', 'Gate 1'),
(429, 2, '1403-01-05 12:45:26', 'enter', 'Gate 1'),
(430, 5, '1403-01-05 12:45:26', 'enter', 'Gate 1'),
(431, 2, '1403-01-05 12:46:02', 'enter', 'Gate 1'),
(432, 2, '1403-01-05 12:46:54', 'enter', 'Gate 1'),
(433, 1, '1403-01-05 12:47:30', 'enter', 'Gate 1'),
(434, 5, '1403-01-05 12:51:23', 'enter', 'Gate 1'),
(435, 2, '1403-01-05 12:51:49', 'enter', 'Gate 1'),
(436, 2, '1403-01-05 12:52:02', 'enter', 'Gate 1'),
(437, 10, '1403-01-05 12:52:28', 'enter', 'Gate 1'),
(439, 5, '1403-01-05 12:54:12', 'enter', 'Gate 1'),
(440, 5, '1403-01-05 12:54:25', 'enter', 'Gate 1'),
(441, 2, '1403-01-05 12:54:38', 'enter', 'Gate 1'),
(442, 5, '1403-01-05 12:54:51', 'enter', 'Gate 1'),
(444, 2, '1403-01-05 12:57:10', 'enter', 'Gate 1'),
(445, 5, '1403-01-05 12:57:10', 'enter', 'Gate 1'),
(446, 2, '1403-01-05 12:57:23', 'enter', 'Gate 1'),
(447, 5, '1403-01-05 12:57:23', 'enter', 'Gate 1'),
(448, 10, '1403-01-05 12:57:36', 'enter', 'Gate 1'),
(449, 7, '1403-01-05 12:57:36', 'enter', 'Gate 1'),
(450, 5, '1403-01-05 12:57:36', 'enter', 'Gate 1'),
(451, 2, '1403-01-05 12:57:49', 'enter', 'Gate 1'),
(453, 10, '1403-01-05 12:58:02', 'enter', 'Gate 1'),
(454, 5, '1403-01-05 12:58:02', 'enter', 'Gate 1'),
(455, 2, '1403-01-05 12:58:02', 'enter', 'Gate 1'),
(456, 2, '1403-01-05 12:58:15', 'enter', 'Gate 1'),
(457, 5, '1403-01-05 12:58:15', 'enter', 'Gate 1'),
(458, 2, '1403-01-05 12:58:28', 'enter', 'Gate 1'),
(470, 1, '1403-01-05 13:04:14', 'enter', 'Gate 1'),
(471, 1, '1403-01-05 13:04:40', 'enter', 'Gate 1'),
(472, 1, '1403-01-05 13:05:06', 'enter', 'Gate 1'),
(473, 1, '1403-01-05 13:05:19', 'enter', 'Gate 1'),
(474, 1, '1403-01-05 13:05:32', 'enter', 'Gate 1'),
(475, 1, '1403-01-05 13:05:45', 'enter', 'Gate 1'),
(476, 1, '1403-01-05 13:05:58', 'enter', 'Gate 1'),
(477, 1, '1403-01-05 13:06:11', 'enter', 'Gate 1'),
(478, 1, '1403-01-05 13:07:03', 'enter', 'Gate 1'),
(479, 1, '1403-01-05 13:07:16', 'enter', 'Gate 1'),
(480, 1, '1403-01-05 13:07:29', 'enter', 'Gate 1'),
(481, 1, '1403-01-05 13:07:42', 'enter', 'Gate 1'),
(482, 1, '1403-01-05 13:07:55', 'enter', 'Gate 1'),
(483, 1, '1403-01-05 13:09:26', 'enter', 'Gate 1'),
(484, 1, '1403-01-05 13:09:52', 'enter', 'Gate 1'),
(485, 1, '1403-01-05 13:10:05', 'enter', 'Gate 1'),
(486, 1, '1403-01-05 13:10:18', 'enter', 'Gate 1'),
(487, 2, '1403-01-05 13:10:44', 'enter', 'Gate 1'),
(488, 1, '1403-01-05 13:10:44', 'enter', 'Gate 1'),
(489, 2, '1403-01-05 13:10:57', 'enter', 'Gate 1'),
(490, 2, '1403-01-05 13:11:10', 'enter', 'Gate 1'),
(491, 1, '1403-01-05 13:13:19', 'enter', 'Gate 1'),
(492, 1, '1403-01-05 13:13:32', 'enter', 'Gate 1'),
(493, 1, '1403-01-05 13:13:58', 'enter', 'Gate 1'),
(495, 1, '1403-01-05 13:16:08', 'enter', 'Gate 1'),
(496, 1, '1403-01-05 13:16:21', 'enter', 'Gate 1'),
(499, 2, '1403-01-05 13:17:00', 'enter', 'Gate 1'),
(500, 7, '1403-01-05 13:17:00', 'enter', 'Gate 1'),
(502, 7, '1403-01-05 13:17:13', 'enter', 'Gate 1'),
(505, 7, '1403-01-05 13:21:00', 'enter', 'Gate 1'),
(507, 7, '1403-01-05 13:21:13', 'enter', 'Gate 1'),
(508, 1, '1403-01-05 13:21:13', 'enter', 'Gate 1'),
(509, 1, '1403-01-05 13:21:26', 'enter', 'Gate 1'),
(511, 7, '1403-01-05 13:21:26', 'enter', 'Gate 1'),
(512, 1, '1403-01-05 13:21:39', 'enter', 'Gate 1'),
(519, 7, '1403-01-05 13:24:18', 'enter', 'Gate 1'),
(521, 1, '1403-01-05 13:24:31', 'enter', 'Gate 1'),
(522, 1, '1403-01-05 13:24:44', 'enter', 'Gate 1'),
(525, 7, '1403-01-05 13:25:23', 'enter', 'Gate 1'),
(526, 1, '1403-01-05 13:25:23', 'enter', 'Gate 1'),
(538, 1, '1403-01-05 13:35:14', 'enter', 'Gate 1'),
(540, 1, '1403-01-05 13:35:27', 'enter', 'Gate 1'),
(542, 1, '1403-01-05 13:35:40', 'enter', 'Gate 1'),
(543, 1, '1403-01-05 13:35:53', 'enter', 'Gate 1'),
(544, 1, '1403-01-05 13:36:06', 'enter', 'Gate 1'),
(545, 1, '1403-01-05 13:40:49', 'enter', 'Gate 1'),
(546, 1, '1403-01-05 13:41:02', 'enter', 'Gate 1'),
(547, 1, '1403-01-05 13:41:15', 'enter', 'Gate 1'),
(548, 1, '1403-01-05 13:41:28', 'enter', 'Gate 1'),
(549, 1, '1403-01-05 13:41:42', 'enter', 'Gate 1'),
(550, 1, '1403-01-05 13:41:55', 'enter', 'Gate 1'),
(551, 1, '1403-01-05 13:42:08', 'enter', 'Gate 1'),
(552, 1, '1403-01-05 13:43:04', 'enter', 'Gate 1'),
(553, 1, '1403-01-05 13:43:17', 'enter', 'Gate 1'),
(554, 1, '1403-01-05 13:44:02', 'enter', 'Gate 1'),
(555, 1, '1403-01-05 13:44:15', 'enter', 'Gate 1'),
(556, 1, '1403-01-05 13:44:28', 'enter', 'Gate 1'),
(557, 1, '1403-01-05 13:44:41', 'enter', 'Gate 1'),
(558, 1, '1403-01-05 13:44:54', 'enter', 'Gate 1'),
(559, 1, '1403-01-05 13:45:07', 'enter', 'Gate 1'),
(560, 1, '1403-01-05 13:45:20', 'enter', 'Gate 1'),
(561, 1, '1403-01-05 13:45:33', 'enter', 'Gate 1'),
(562, 1, '1403-01-05 13:45:46', 'enter', 'Gate 1'),
(563, 1, '1403-01-05 13:45:59', 'enter', 'Gate 1'),
(564, 1, '1403-01-06 12:10:35', 'enter', 'Gate 1'),
(565, 1, '1403-01-06 12:10:48', 'enter', 'Gate 1'),
(566, 1, '1403-01-06 12:11:01', 'enter', 'Gate 1'),
(567, 1, '1403-01-06 12:11:14', 'enter', 'Gate 1'),
(568, 1, '1403-01-06 12:11:27', 'enter', 'Gate 1'),
(569, 1, '1403-01-06 12:11:58', 'enter', 'Gate 1'),
(570, 1, '1403-01-06 12:12:11', 'enter', 'Gate 1'),
(571, 1, '1403-01-06 12:12:24', 'enter', 'Gate 1'),
(572, 1, '1403-01-06 12:15:32', 'enter', 'Gate 1'),
(573, 1, '1403-01-06 12:15:45', 'enter', 'Gate 1'),
(574, 1, '1403-01-06 12:16:21', 'enter', 'Gate 1'),
(575, 1, '1403-01-06 12:16:34', 'enter', 'Gate 1'),
(576, 1, '1403-01-06 12:16:47', 'enter', 'Gate 1'),
(577, 1, '1403-01-06 12:17:48', 'enter', 'Gate 1'),
(578, 1, '1403-01-06 12:18:01', 'enter', 'Gate 1'),
(579, 1, '1403-01-06 13:53:47', 'enter', 'Gate 1'),
(580, 1, '1403-01-06 13:54:00', 'enter', 'Gate 1'),
(581, 5, '1403-01-06 13:54:00', 'enter', 'Gate 1'),
(582, 1, '1403-01-06 13:54:13', 'enter', 'Gate 1'),
(583, 5, '1403-01-06 13:54:13', 'enter', 'Gate 1'),
(584, 1, '1403-01-06 13:54:26', 'enter', 'Gate 1'),
(585, 1, '1403-01-06 13:54:39', 'enter', 'Gate 1'),
(586, 1, '1403-01-06 13:54:52', 'enter', 'Gate 1'),
(587, 1, '1403-01-06 13:55:05', 'enter', 'Gate 1'),
(588, 1, '1403-01-06 13:55:18', 'enter', 'Gate 1'),
(589, 1, '1403-01-06 13:55:44', 'enter', 'Gate 1'),
(590, 1, '1403-01-06 13:56:49', 'enter', 'Gate 1'),
(591, 1, '1403-01-06 13:57:15', 'enter', 'Gate 1'),
(592, 1, '1403-01-06 13:57:28', 'enter', 'Gate 1'),
(593, 2, '1403-01-06 13:57:41', 'enter', 'Gate 1'),
(594, 1, '1403-01-06 13:58:07', 'enter', 'Gate 1'),
(595, 1, '1403-01-06 13:58:20', 'enter', 'Gate 1'),
(596, 1, '1403-01-06 13:58:46', 'enter', 'Gate 1'),
(597, 1, '1403-01-06 13:59:12', 'enter', 'Gate 1'),
(598, 5, '1403-01-06 13:59:12', 'enter', 'Gate 1'),
(599, 7, '1403-01-06 13:59:25', 'enter', 'Gate 1'),
(600, 5, '1403-01-06 13:59:25', 'enter', 'Gate 1'),
(601, 1, '1403-01-06 13:59:38', 'enter', 'Gate 1'),
(602, 1, '1403-01-06 13:59:51', 'enter', 'Gate 1'),
(603, 5, '1403-01-06 14:00:04', 'enter', 'Gate 1'),
(604, 1, '1403-01-06 14:00:17', 'enter', 'Gate 1'),
(605, 7, '1403-01-06 14:00:17', 'enter', 'Gate 1'),
(606, 1, '1403-01-06 14:00:30', 'enter', 'Gate 1'),
(607, 1, '1403-01-06 14:05:36', 'enter', 'Gate 1'),
(608, 1, '1403-01-06 14:06:15', 'enter', 'Gate 1'),
(609, 1, '1403-01-06 14:06:28', 'enter', 'Gate 1'),
(610, 1, '1403-01-06 14:07:07', 'enter', 'Gate 1'),
(611, 1, '1403-01-06 14:08:24', 'enter', 'Gate 1'),
(612, 1, '1403-01-06 14:09:16', 'enter', 'Gate 1'),
(613, 2, '1403-01-06 14:10:34', 'enter', 'Gate 1'),
(614, 2, '1403-01-06 14:10:47', 'enter', 'Gate 1'),
(615, 1, '1403-01-06 14:11:26', 'enter', 'Gate 1'),
(616, 1, '1403-01-06 14:11:39', 'enter', 'Gate 1'),
(617, 2, '1403-01-06 14:12:18', 'enter', 'Gate 1'),
(618, 1, '1403-01-06 14:12:31', 'enter', 'Gate 1'),
(619, 2, '1403-01-06 14:16:56', 'enter', 'Gate 1'),
(620, 2, '1403-01-06 14:17:32', 'enter', 'Gate 1'),
(621, 1, '1403-01-06 14:17:32', 'enter', 'Gate 1'),
(622, 2, '1403-01-06 14:18:08', 'enter', 'Gate 1'),
(623, 2, '1403-01-06 14:18:44', 'enter', 'Gate 1'),
(624, 2, '1403-01-06 14:19:20', 'enter', 'Gate 1'),
(625, 10, '1403-01-06 14:19:20', 'enter', 'Gate 1'),
(626, 1, '1403-01-06 14:19:20', 'enter', 'Gate 1'),
(627, 2, '1403-01-06 14:19:56', 'enter', 'Gate 1'),
(628, 1, '1403-01-06 14:19:56', 'enter', 'Gate 1'),
(629, 2, '1403-01-06 14:20:32', 'enter', 'Gate 1'),
(630, 4, '1403-01-06 14:20:32', 'enter', 'Gate 1'),
(631, 2, '1403-01-06 14:21:08', 'enter', 'Gate 1'),
(632, 2, '1403-01-06 14:21:44', 'enter', 'Gate 1'),
(633, 2, '1403-01-06 14:22:20', 'enter', 'Gate 1'),
(634, 1, '1403-01-06 14:22:20', 'enter', 'Gate 1'),
(635, 2, '1403-01-06 14:22:56', 'enter', 'Gate 1'),
(636, 10, '1403-01-06 14:22:56', 'enter', 'Gate 1'),
(637, 1, '1403-01-06 14:22:56', 'enter', 'Gate 1'),
(639, 1, '1403-01-07 13:38:34', 'enter', 'Gate 1'),
(640, 1, '1403-01-07 13:39:11', 'enter', 'Gate 1'),
(641, 1, '1403-01-07 13:39:47', 'enter', 'Gate 1'),
(642, 1, '1403-01-14 11:09:11', 'enter', 'Gate 1'),
(643, 1, '1403-01-14 11:10:23', 'enter', 'Gate 1'),
(644, 1, '1403-01-14 11:11:35', 'enter', 'Gate 1'),
(645, 1, '1403-01-14 11:15:44', 'enter', 'Gate 1'),
(646, 1, '1403-01-14 11:16:03', 'enter', 'Gate 1'),
(648, 1, '1403-01-14 11:18:54', 'enter', 'Gate 1'),
(649, 1, '1403-01-14 11:19:13', 'enter', 'Gate 1'),
(650, 1, '1403-01-14 11:19:32', 'enter', 'Gate 1'),
(651, 1, '1403-01-14 11:19:51', 'enter', 'Gate 1'),
(652, 1, '1403-01-14 11:25:40', 'enter', 'Gate 1'),
(653, 1, '1403-01-14 11:25:59', 'enter', 'Gate 1'),
(654, 10, '1403-01-14 11:28:31', 'enter', 'Gate 1'),
(655, 10, '1403-01-14 11:28:50', 'enter', 'Gate 1'),
(656, 10, '1403-01-14 11:30:44', 'enter', 'Gate 1'),
(657, 1, '1403-01-14 11:30:44', 'enter', 'Gate 1'),
(658, 1, '1403-01-14 11:31:03', 'enter', 'Gate 1'),
(659, 10, '1403-01-14 11:35:01', 'enter', 'Gate 1'),
(660, 1, '1403-01-14 11:35:20', 'enter', 'Gate 1'),
(661, 10, '1403-01-14 11:35:20', 'enter', 'Gate 1'),
(662, 1, '1403-01-14 11:35:39', 'enter', 'Gate 1'),
(663, 10, '1403-01-14 11:35:39', 'enter', 'Gate 1'),
(664, 10, '1403-01-14 11:35:58', 'enter', 'Gate 1'),
(665, 10, '1403-01-14 11:36:17', 'enter', 'Gate 1'),
(666, 1, '1403-01-14 11:36:36', 'enter', 'Gate 1'),
(667, 10, '1403-01-14 11:36:36', 'enter', 'Gate 1'),
(668, 10, '1403-01-14 11:36:55', 'enter', 'Gate 1'),
(669, 10, '1403-01-14 11:39:35', 'enter', 'Gate 1'),
(670, 10, '1403-01-14 11:39:54', 'enter', 'Gate 1'),
(671, 3, '1403-01-14 11:40:32', 'enter', 'Gate 1'),
(672, 3, '1403-01-14 11:40:51', 'enter', 'Gate 1'),
(673, 3, '1403-01-14 11:41:10', 'enter', 'Gate 1'),
(674, 1, '1403-01-14 11:42:26', 'enter', 'Gate 1'),
(675, 1, '1403-01-14 11:42:45', 'enter', 'Gate 1'),
(676, 3, '1403-01-14 11:42:45', 'enter', 'Gate 1'),
(677, 1, '1403-01-14 11:43:04', 'enter', 'Gate 1'),
(678, 1, '1403-01-14 11:43:23', 'enter', 'Gate 1'),
(679, 1, '1403-01-14 11:44:22', 'enter', 'Gate 1'),
(680, 10, '1403-01-14 11:44:41', 'enter', 'Gate 1'),
(681, 1, '1403-01-20 20:52:32', 'enter', 'Gate 1'),
(685, 1, '1403-01-22 19:26:57', 'enter', 'Gate 1'),
(686, 1, '1403-01-22 19:27:19', 'enter', 'Gate 1'),
(697, 3, '1403-01-22 19:53:38', 'enter', 'Gate 1'),
(698, 3, '1403-01-22 19:53:59', 'enter', 'Gate 1'),
(699, 1, '1403-01-23 19:07:52', 'enter', 'Gate 1'),
(700, 1, '1403-01-24 10:20:15', 'enter', 'Gate 1'),
(701, 1, '1403-01-25 20:14:14', 'enter', 'Gate 1'),
(702, 1, '1403-01-25 20:17:09', 'enter', 'Gate 1'),
(703, 1, '1403-01-25 20:17:30', 'enter', 'Gate 1'),
(704, 1, '1403-01-25 20:18:33', 'enter', 'Gate 1'),
(705, 1, '1403-01-25 20:19:15', 'enter', 'Gate 1'),
(706, 5, '1403-01-25 20:19:15', 'enter', 'Gate 1'),
(707, 1, '1403-01-25 20:19:57', 'enter', 'Gate 1'),
(708, 1, '1403-01-25 20:20:18', 'enter', 'Gate 1'),
(709, 1, '1403-01-25 20:21:42', 'enter', 'Gate 1'),
(710, 1, '1403-01-25 20:22:45', 'enter', 'Gate 1'),
(711, 5, '1403-01-25 20:22:45', 'enter', 'Gate 1'),
(712, 5, '1403-01-25 20:24:30', 'enter', 'Gate 1'),
(713, 5, '1403-01-25 20:24:51', 'enter', 'Gate 1'),
(714, 1, '1403-01-25 20:25:12', 'enter', 'Gate 1'),
(715, 1, '1403-01-25 20:25:33', 'enter', 'Gate 1'),
(716, 3, '1403-01-25 20:25:33', 'enter', 'Gate 1'),
(717, 1, '1403-01-25 20:25:54', 'enter', 'Gate 1'),
(718, 3, '1403-01-25 20:25:54', 'enter', 'Gate 1'),
(720, 1, '1403-01-25 20:34:38', 'enter', 'Gate 1'),
(721, 5, '1403-01-25 20:34:59', 'enter', 'Gate 1'),
(722, 1, '1403-01-25 20:34:59', 'enter', 'Gate 1'),
(724, 1, '1403-01-25 20:36:02', 'enter', 'Gate 1'),
(725, 1, '1403-01-25 20:36:23', 'enter', 'Gate 1'),
(726, 1, '1403-01-25 20:36:44', 'enter', 'Gate 1'),
(727, 1, '1403-01-25 20:37:05', 'enter', 'Gate 1'),
(728, 2, '1403-01-25 20:37:26', 'enter', 'Gate 1'),
(729, 5, '1403-01-25 20:37:26', 'enter', 'Gate 1'),
(731, 1, '1403-01-25 20:37:26', 'enter', 'Gate 1'),
(733, 1, '1403-01-25 20:37:47', 'enter', 'Gate 1'),
(734, 5, '1403-01-25 20:38:08', 'enter', 'Gate 1'),
(736, 2, '1403-01-25 20:38:08', 'enter', 'Gate 1'),
(737, 1, '1403-01-25 20:38:29', 'enter', 'Gate 1'),
(739, 1, '1403-01-25 20:39:11', 'enter', 'Gate 1'),
(741, 1, '1403-01-25 20:39:32', 'enter', 'Gate 1'),
(742, 1, '1403-01-25 20:39:53', 'enter', 'Gate 1'),
(743, 5, '1403-01-25 20:43:33', 'enter', 'Gate 1'),
(744, 1, '1403-01-25 20:46:00', 'enter', 'Gate 1'),
(745, 1, '1403-01-25 20:47:03', 'enter', 'Gate 1'),
(747, 1, '1403-01-25 20:47:24', 'enter', 'Gate 1'),
(748, 1, '1403-01-25 20:54:00', 'enter', 'Gate 1'),
(749, 5, '1403-01-25 20:54:00', 'enter', 'Gate 1'),
(750, 1, '1403-01-25 20:55:03', 'enter', 'Gate 1'),
(751, 5, '1403-01-25 20:55:03', 'enter', 'Gate 1'),
(752, 1, '1403-01-25 20:55:24', 'enter', 'Gate 1'),
(753, 1, '1403-01-25 20:56:27', 'enter', 'Gate 1'),
(754, 5, '1403-01-25 20:56:27', 'enter', 'Gate 1'),
(755, 1, '1403-01-25 20:56:48', 'enter', 'Gate 1'),
(756, 5, '1403-01-25 20:57:09', 'enter', 'Gate 1'),
(757, 1, '1403-01-25 20:57:30', 'enter', 'Gate 1'),
(758, 5, '1403-01-25 20:57:30', 'enter', 'Gate 1'),
(759, 5, '1403-01-25 21:16:03', 'enter', 'Gate 1'),
(760, 2, '1403-01-25 21:16:03', 'enter', 'Gate 1'),
(761, 1, '1403-01-25 21:16:03', 'enter', 'Gate 1'),
(762, 10, '1403-01-26 20:51:44', 'enter', 'Gate 1'),
(763, 2, '1403-01-26 20:52:05', 'enter', 'Gate 1'),
(764, 10, '1403-01-26 20:52:05', 'enter', 'Gate 1'),
(765, 7, '1403-01-26 20:52:47', 'enter', 'Gate 1'),
(766, 5, '1403-01-26 20:52:47', 'enter', 'Gate 1'),
(767, 10, '1403-01-26 20:52:47', 'enter', 'Gate 1'),
(768, 5, '1403-01-26 20:53:57', 'enter', 'Gate 1'),
(769, 10, '1403-01-26 20:53:57', 'enter', 'Gate 1'),
(770, 7, '1403-01-26 20:53:57', 'enter', 'Gate 1'),
(771, 1, '1403-01-26 20:54:18', 'enter', 'Gate 1'),
(772, 10, '1403-01-26 20:54:18', 'enter', 'Gate 1'),
(773, 5, '1403-01-26 20:54:39', 'enter', 'Gate 1'),
(774, 1, '1403-01-26 20:54:39', 'enter', 'Gate 1'),
(775, 10, '1403-01-26 20:54:39', 'enter', 'Gate 1'),
(776, 2, '1403-01-26 20:54:39', 'enter', 'Gate 1'),
(777, 1, '1403-01-26 20:55:00', 'enter', 'Gate 1'),
(778, 5, '1403-01-26 20:55:00', 'enter', 'Gate 1'),
(779, 10, '1403-01-26 20:55:00', 'enter', 'Gate 1'),
(780, 2, '1403-01-26 20:55:00', 'enter', 'Gate 1'),
(781, 1, '1403-01-26 20:58:44', 'enter', 'Gate 1'),
(782, 10, '1403-01-26 20:58:44', 'enter', 'Gate 1'),
(783, 5, '1403-01-26 20:59:26', 'enter', 'Gate 1'),
(784, 1, '1403-01-26 21:00:50', 'enter', 'Gate 1'),
(785, 5, '1403-01-26 21:03:02', 'enter', 'Gate 1'),
(786, 1, '1403-01-26 21:04:05', 'enter', 'Gate 1'),
(787, 10, '1403-01-26 21:05:51', 'enter', 'Gate 1'),
(797, 10, '1403-01-26 21:09:26', 'enter', 'Gate 1'),
(798, 7, '1403-01-26 21:09:47', 'enter', 'Gate 1'),
(799, 10, '1403-01-26 21:09:47', 'enter', 'Gate 1'),
(800, 1, '1403-01-26 21:10:19', 'enter', 'Gate 1'),
(801, 10, '1403-01-26 21:10:19', 'enter', 'Gate 1'),
(802, 4, '1403-01-26 21:10:40', 'enter', 'Gate 1'),
(803, 1, '1403-01-26 21:10:40', 'enter', 'Gate 1'),
(804, 10, '1403-01-26 21:10:40', 'enter', 'Gate 1'),
(805, 1, '1403-01-26 21:11:01', 'enter', 'Gate 1'),
(806, 10, '1403-01-26 21:11:01', 'enter', 'Gate 1'),
(807, 10, '1403-01-26 21:11:22', 'enter', 'Gate 1'),
(811, 10, '1403-01-26 21:12:46', 'enter', 'Gate 1'),
(814, 2, '1403-01-26 21:13:07', 'enter', 'Gate 1'),
(815, 1, '1403-01-26 21:13:28', 'enter', 'Gate 1'),
(816, 10, '1403-01-26 21:13:28', 'enter', 'Gate 1'),
(819, 5, '1403-01-26 21:15:31', 'enter', 'Gate 1'),
(820, 5, '1403-01-26 21:15:52', 'enter', 'Gate 1'),
(827, 3, '1403-01-27 09:12:46', 'enter', 'Gate 1'),
(828, 3, '1403-01-27 09:13:07', 'enter', 'Gate 1'),
(829, 15, '1403-01-27 09:13:28', 'enter', 'Gate 1'),
(833, 3, '1403-01-27 09:17:19', 'enter', 'Gate 1'),
(1000, 3, '1403-01-27 16:16:16', 'exit', 'gate 2'),
(1001, 3, '1403-01-27 09:18:43', 'enter', 'Gate 1'),
(1002, 1, '1403-01-28 18:35:19', 'enter', 'Gate 1'),
(1003, 1, '1403-01-28 18:35:40', 'enter', 'Gate 1'),
(1021, 2, '1403-01-31 10:23:15', 'enter', 'Gate 1'),
(1022, 2, '1403-01-31 10:23:22', 'exit', 'Gate 1'),
(1024, 1, '1403-01-31 10:24:04', 'exit', 'Gate 1'),
(1025, 2, '1403-01-31 10:24:04', 'exit', 'Gate 1'),
(1032, 1, '1403-02-05 19:13:01', 'enter', 'Gate 1'),
(1033, 1, '1403-02-05 19:17:55', 'exit', 'Gate 2'),
(1034, 1, '1403-02-05 19:18:58', 'enter', 'Gate 1'),
(1035, 1, '1403-02-05 19:19:40', 'exit', 'Gate 2'),
(1036, 1, '1403-02-05 19:20:01', 'exit', 'Gate 2'),
(1037, 1, '1403-02-05 19:22:28', 'enter', 'Gate 1'),
(1040, 1, '1403-02-05 19:24:55', 'exit', 'Gate 2'),
(1041, 1, '1403-02-05 19:25:16', 'exit', 'Gate 2'),
(1042, 1, '1403-02-05 19:25:37', 'exit', 'Gate 2'),
(1043, 1, '1403-02-05 19:25:58', 'exit', 'Gate 2'),
(1044, 1, '1403-02-05 19:26:19', 'exit', 'Gate 2'),
(1045, 7, '1403-02-06 11:20:18', 'enter', 'Gate 1'),
(1046, 3, '1403-02-06 11:20:18', 'enter', 'Gate 1'),
(1047, 3, '1403-02-06 11:20:39', 'exit', 'Gate 2'),
(1048, 3, '1403-02-06 11:21:42', 'exit', 'Gate 2'),
(1049, 3, '1403-02-06 11:22:03', 'enter', 'Gate 1'),
(1050, 3, '1403-02-06 11:22:24', 'enter', 'Gate 1'),
(1051, 3, '1403-02-06 11:23:27', 'enter', 'Gate 1'),
(1052, 3, '1403-02-06 11:24:30', 'exit', 'Gate 2'),
(1053, 3, '1403-02-06 11:24:30', 'enter', 'Gate 1'),
(1054, 3, '1403-02-06 11:24:51', 'enter', 'Gate 1'),
(1055, 3, '1403-02-06 11:25:12', 'enter', 'Gate 1'),
(1056, 3, '1403-02-06 11:25:33', 'enter', 'Gate 1'),
(1057, 3, '1403-02-06 11:25:54', 'enter', 'Gate 1'),
(1058, 3, '1403-02-06 11:26:15', 'enter', 'Gate 1'),
(1059, 3, '1403-02-06 11:26:36', 'enter', 'Gate 1'),
(1060, 3, '1403-02-06 11:26:57', 'enter', 'Gate 1'),
(1061, 3, '1403-02-06 11:27:18', 'enter', 'Gate 1'),
(1062, 3, '1403-02-06 11:27:39', 'enter', 'Gate 1'),
(1063, 3, '1403-02-06 11:28:00', 'enter', 'Gate 1'),
(1064, 3, '1403-02-06 11:28:21', 'enter', 'Gate 1'),
(1065, 3, '1403-02-06 11:28:42', 'enter', 'Gate 1'),
(1066, 3, '1403-02-06 11:29:03', 'enter', 'Gate 1'),
(1067, 3, '1403-02-06 11:29:24', 'enter', 'Gate 1'),
(1068, 3, '1403-02-06 11:29:45', 'enter', 'Gate 1'),
(1069, 3, '1403-02-06 11:30:06', 'enter', 'Gate 1'),
(1070, 7, '1403-02-06 11:33:15', 'enter', 'Gate 1'),
(1071, 3, '1403-02-06 11:33:15', 'enter', 'Gate 1'),
(1072, 3, '1403-02-06 11:33:36', 'enter', 'Gate 1'),
(1073, 2, '1403-02-06 11:33:36', 'enter', 'Gate 1'),
(1074, 3, '1403-02-06 11:33:57', 'enter', 'Gate 1'),
(1075, 3, '1403-02-06 11:34:18', 'enter', 'Gate 1'),
(1076, 2, '1403-02-06 11:34:18', 'enter', 'Gate 1'),
(1077, 3, '1403-02-06 11:34:39', 'enter', 'Gate 1'),
(1078, 3, '1403-02-06 11:35:00', 'enter', 'Gate 1'),
(1079, 1, '1403-02-06 11:35:21', 'enter', 'Gate 1'),
(1080, 7, '1403-02-06 11:35:21', 'enter', 'Gate 1'),
(1081, 3, '1403-02-06 11:35:21', 'enter', 'Gate 1'),
(1082, 1, '1403-02-06 11:35:21', 'exit', 'Gate 2'),
(1083, 3, '1403-02-06 11:35:21', 'exit', 'Gate 2'),
(1084, 1, '1403-02-06 11:35:42', 'exit', 'Gate 2'),
(1085, 1, '1403-02-06 11:36:03', 'exit', 'Gate 2'),
(1086, 1, '1403-02-06 11:36:24', 'exit', 'Gate 2'),
(1087, 1, '1403-02-06 11:36:24', 'enter', 'Gate 1'),
(1088, 1, '1403-02-08 20:53:52', 'enter', 'Gate 1'),
(1089, 1, '1403-02-08 20:54:13', 'enter', 'Gate 1'),
(1090, 1, '1403-02-08 20:54:34', 'enter', 'Gate 1'),
(1091, 1, '1403-02-08 20:54:55', 'enter', 'Gate 1'),
(1092, 1, '1403-02-13 14:06:40', 'enter', 'Gate 1'),
(1093, 1, '1403-02-13 14:07:35', 'enter', 'Gate 1'),
(1094, 1, '1403-02-13 14:07:56', 'enter', 'Gate 1'),
(1095, 1, '1403-03-24 18:34:58', 'enter', 'Gate 1'),
(1096, 1, '1403-03-24 18:39:39', 'enter', 'Gate 1'),
(1097, 1, '1403-03-24 18:40:00', 'enter', 'Gate 1'),
(1098, 1, '1403-03-31 09:39:34', 'enter', 'Gate 1'),
(1099, 21, '1403-03-31 09:39:55', 'enter', 'Gate 1'),
(1100, 1, '1403-03-31 09:39:55', 'enter', 'Gate 1'),
(1101, 21, '1403-03-31 09:46:38', 'enter', 'Gate 1'),
(1102, 1, '1403-03-31 09:46:38', 'enter', 'Gate 1'),
(1103, 21, '1403-03-31 09:46:59', 'enter', 'Gate 1'),
(1104, 1, '1403-03-31 09:46:59', 'enter', 'Gate 1'),
(1105, 21, '1403-03-31 09:47:20', 'enter', 'Gate 1'),
(1106, 1, '1403-03-31 09:47:20', 'enter', 'Gate 1'),
(1107, 1, '1403-03-31 10:06:52', 'enter', 'Gate 1'),
(1108, 21, '1403-03-31 10:06:52', 'enter', 'Gate 1'),
(1109, 1, '1403-03-31 10:07:13', 'enter', 'Gate 1'),
(1110, 15, '1403-03-31 10:07:13', 'enter', 'Gate 1'),
(1111, 21, '1403-03-31 10:07:13', 'enter', 'Gate 1'),
(1112, 1, '1403-04-01 10:24:20', 'enter', 'Gate 1');

-- --------------------------------------------------------

--
-- Structure for view `staff_attendance_view`
--
DROP TABLE IF EXISTS `staff_attendance_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`debian-sys-maint`@`localhost` SQL SECURITY DEFINER VIEW `staff_attendance_view`  AS SELECT `s`.`staff_id` AS `staff_id`, `s`.`national_id` AS `national_id`, `s`.`first_name` AS `first_name`, `s`.`last_name` AS `last_name`, `s`.`section` AS `section`, cast(`t`.`log_time` as date) AS `date`, min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)) AS `enter_time`, max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end)) AS `exit_time`, concat(floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') AS `attendance_hours`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) < 480) then concat((8 - floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60))),'h ',(60 - (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60)),'m') else '-' end) AS `deduction_of_attendance`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) > 480) then concat((floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)) - 8),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') else '-' end) AS `extra_attendance` FROM (`staff` `s` join `time_log` `t` on((`s`.`staff_id` = `t`.`staff_id`))) GROUP BY `s`.`staff_id`, cast(`t`.`log_time` as date) ;

-- --------------------------------------------------------

--
-- Structure for view `staff_attendance_view_IT`
--
DROP TABLE IF EXISTS `staff_attendance_view_IT`;

CREATE ALGORITHM=UNDEFINED DEFINER=`debian-sys-maint`@`localhost` SQL SECURITY DEFINER VIEW `staff_attendance_view_IT`  AS SELECT `s`.`staff_id` AS `staff_id`, `s`.`national_id` AS `national_id`, `s`.`first_name` AS `first_name`, `s`.`last_name` AS `last_name`, `s`.`section` AS `section`, cast(`t`.`log_time` as date) AS `date`, min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)) AS `enter_time`, max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end)) AS `exit_time`, concat(floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') AS `attendance_hours`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) < 480) then concat((8 - floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60))),'h ',(60 - (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60)),'m') else '-' end) AS `deduction_of_attendance`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) > 480) then concat((floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)) - 8),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') else '-' end) AS `extra_attendance` FROM (`staff` `s` join `time_log` `t` on((`s`.`staff_id` = `t`.`staff_id`))) WHERE (`s`.`section` = 'IT') GROUP BY `s`.`staff_id`, cast(`t`.`log_time` as date) ;

-- --------------------------------------------------------

--
-- Structure for view `staff_attendance_view_اداری`
--
DROP TABLE IF EXISTS `staff_attendance_view_اداری`;

CREATE ALGORITHM=UNDEFINED DEFINER=`debian-sys-maint`@`localhost` SQL SECURITY DEFINER VIEW `staff_attendance_view_اداری`  AS SELECT `s`.`staff_id` AS `staff_id`, `s`.`national_id` AS `national_id`, `s`.`first_name` AS `first_name`, `s`.`last_name` AS `last_name`, `s`.`section` AS `section`, cast(`t`.`log_time` as date) AS `date`, min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)) AS `enter_time`, max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end)) AS `exit_time`, concat(floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') AS `attendance_hours`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) < 480) then concat((8 - floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60))),'h ',(60 - (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60)),'m') else '-' end) AS `deduction_of_attendance`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) > 480) then concat((floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)) - 8),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') else '-' end) AS `extra_attendance` FROM (`staff` `s` join `time_log` `t` on((`s`.`staff_id` = `t`.`staff_id`))) WHERE (`s`.`section` = 'اداری') GROUP BY `s`.`staff_id`, cast(`t`.`log_time` as date) ;

-- --------------------------------------------------------

--
-- Structure for view `staff_attendance_view_مالی`
--
DROP TABLE IF EXISTS `staff_attendance_view_مالی`;

CREATE ALGORITHM=UNDEFINED DEFINER=`debian-sys-maint`@`localhost` SQL SECURITY DEFINER VIEW `staff_attendance_view_مالی`  AS SELECT `s`.`staff_id` AS `staff_id`, `s`.`national_id` AS `national_id`, `s`.`first_name` AS `first_name`, `s`.`last_name` AS `last_name`, `s`.`section` AS `section`, cast(`t`.`log_time` as date) AS `date`, min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)) AS `enter_time`, max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end)) AS `exit_time`, concat(floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') AS `attendance_hours`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) < 480) then concat((8 - floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60))),'h ',(60 - (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60)),'m') else '-' end) AS `deduction_of_attendance`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) > 480) then concat((floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)) - 8),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') else '-' end) AS `extra_attendance` FROM (`staff` `s` join `time_log` `t` on((`s`.`staff_id` = `t`.`staff_id`))) WHERE (`s`.`section` = 'مالی') GROUP BY `s`.`staff_id`, cast(`t`.`log_time` as date) ;

-- --------------------------------------------------------

--
-- Structure for view `staff_attendance_view_پژوهش`
--
DROP TABLE IF EXISTS `staff_attendance_view_پژوهش`;

CREATE ALGORITHM=UNDEFINED DEFINER=`debian-sys-maint`@`localhost` SQL SECURITY DEFINER VIEW `staff_attendance_view_پژوهش`  AS SELECT `s`.`staff_id` AS `staff_id`, `s`.`national_id` AS `national_id`, `s`.`first_name` AS `first_name`, `s`.`last_name` AS `last_name`, `s`.`section` AS `section`, cast(`t`.`log_time` as date) AS `date`, min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)) AS `enter_time`, max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end)) AS `exit_time`, concat(floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') AS `attendance_hours`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) < 480) then concat((8 - floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60))),'h ',(60 - (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60)),'m') else '-' end) AS `deduction_of_attendance`, (case when (timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) > 480) then concat((floor((timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) / 60)) - 8),'h ',(timestampdiff(MINUTE,min((case when (`t`.`log_type` = 'enter') then `t`.`log_time` end)),max((case when (`t`.`log_type` = 'exit') then `t`.`log_time` end))) % 60),'m') else '-' end) AS `extra_attendance` FROM (`staff` `s` join `time_log` `t` on((`s`.`staff_id` = `t`.`staff_id`))) WHERE (`s`.`section` = 'پژوهش') GROUP BY `s`.`staff_id`, cast(`t`.`log_time` as date) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `national_id` (`national_id`);

--
-- Indexes for table `time_log`
--
ALTER TABLE `time_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_staff_id` (`staff_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=515316;

--
-- AUTO_INCREMENT for table `time_log`
--
ALTER TABLE `time_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1113;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `time_log`
--
ALTER TABLE `time_log`
  ADD CONSTRAINT `fk_staff_id` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
