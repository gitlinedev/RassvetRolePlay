-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 21 2024 г., 16:00
-- Версия сервера: 10.3.31-MariaDB-0+deb10u1
-- Версия PHP: 7.3.31-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `gs256042`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Referal` varchar(24) NOT NULL,
  `Money` int(200) NOT NULL DEFAULT 0,
  `Donate` int(10) NOT NULL DEFAULT 0,
  `sex` int(1) NOT NULL DEFAULT 0,
  `skin` int(3) NOT NULL DEFAULT 0,
  `Level` int(10) NOT NULL DEFAULT 0,
  `exp` int(3) NOT NULL DEFAULT 0,
  `Meat` int(3) NOT NULL DEFAULT 0,
  `member` int(10) NOT NULL DEFAULT 0,
  `rank` int(10) NOT NULL DEFAULT 0,
  `skinm` int(3) NOT NULL DEFAULT 0,
  `Leader` int(10) NOT NULL DEFAULT 0,
  `Admin` int(10) NOT NULL DEFAULT 0,
  `RegIP` varchar(16) NOT NULL DEFAULT '127.0.0.1',
  `LoginIP` varchar(16) NOT NULL DEFAULT '127.0.0.1',
  `RegisterDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `LoginDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `salary` int(10) NOT NULL DEFAULT 0,
  `bank` int(10) NOT NULL DEFAULT 0,
  `licb` int(1) NOT NULL DEFAULT 0,
  `licg` int(1) NOT NULL DEFAULT 0,
  `business` int(10) NOT NULL DEFAULT -1,
  `house` int(10) NOT NULL DEFAULT -1,
  `kv` int(10) NOT NULL DEFAULT -1,
  `padik` int(10) NOT NULL DEFAULT -1,
  `jb` int(10) NOT NULL DEFAULT -1,
  `ab` int(10) NOT NULL DEFAULT -1,
  `car_1` int(10) NOT NULL DEFAULT 0,
  `carfuel_1` int(10) NOT NULL DEFAULT 0,
  `car_color1_1` int(10) NOT NULL DEFAULT 0,
  `car_color2_1` int(10) NOT NULL DEFAULT 0,
  `car_2` int(10) NOT NULL DEFAULT 0,
  `carfuel_2` int(10) NOT NULL DEFAULT 0,
  `car_color1_2` int(10) NOT NULL DEFAULT 0,
  `car_color2_2` int(10) NOT NULL DEFAULT 0,
  `car_3` int(10) NOT NULL DEFAULT 0,
  `carfuel_3` int(10) NOT NULL DEFAULT 0,
  `car_color1_3` int(10) NOT NULL DEFAULT 0,
  `car_tpposx` float DEFAULT NULL,
  `car_tpposy` float DEFAULT NULL,
  `car_tpposz` float DEFAULT NULL,
  `car_tpangle` float DEFAULT 268.932,
  `patr` int(10) NOT NULL DEFAULT 0,
  `met` int(10) NOT NULL DEFAULT 0,
  `drugs` int(10) NOT NULL DEFAULT 0,
  `wanted` int(10) NOT NULL DEFAULT 0,
  `number` int(10) NOT NULL DEFAULT 0,
  `number_m` int(10) NOT NULL DEFAULT 0,
  `phone` int(10) NOT NULL DEFAULT 0,
  `phonebook` int(10) NOT NULL DEFAULT 0,
  `healthchest` int(2) NOT NULL DEFAULT 0,
  `mask` int(2) NOT NULL DEFAULT 0,
  `dir` int(10) NOT NULL DEFAULT 0,
  `Satiety` int(10) NOT NULL DEFAULT 0,
  `HealthPoints` int(10) NOT NULL DEFAULT 0,
  `arm` int(10) NOT NULL DEFAULT 0,
  `med` int(10) NOT NULL DEFAULT 0,
  `spawn` int(10) NOT NULL DEFAULT 0,
  `hospital` int(10) NOT NULL DEFAULT 0,
  `job` int(2) NOT NULL DEFAULT 0,
  `polit` int(10) NOT NULL DEFAULT 0,
  `d_skill` int(10) NOT NULL DEFAULT 0,
  `d_exp` int(10) NOT NULL DEFAULT 0,
  `gun0` int(10) NOT NULL DEFAULT 0,
  `gun1` int(10) NOT NULL DEFAULT 0,
  `gun2` int(10) NOT NULL DEFAULT 0,
  `gun3` int(10) NOT NULL DEFAULT 0,
  `gun4` int(10) NOT NULL DEFAULT 0,
  `gun5` int(10) NOT NULL DEFAULT 0,
  `gun6` int(10) NOT NULL DEFAULT 0,
  `gun7` int(10) NOT NULL DEFAULT 0,
  `gun8` int(10) NOT NULL DEFAULT 0,
  `gun9` int(10) NOT NULL DEFAULT 0,
  `gun10` int(10) NOT NULL DEFAULT 0,
  `gun11` int(10) NOT NULL DEFAULT 0,
  `gun12` int(10) NOT NULL DEFAULT 0,
  `ammo0` int(10) NOT NULL DEFAULT 0,
  `ammo1` int(10) NOT NULL DEFAULT 0,
  `ammo2` int(10) NOT NULL DEFAULT 0,
  `ammo3` int(10) NOT NULL DEFAULT 0,
  `ammo4` int(10) NOT NULL DEFAULT 0,
  `ammo5` int(10) NOT NULL DEFAULT 0,
  `ammo6` int(10) NOT NULL DEFAULT 0,
  `ammo7` int(10) NOT NULL DEFAULT 0,
  `ammo8` int(10) NOT NULL DEFAULT 0,
  `ammo9` int(10) NOT NULL DEFAULT 0,
  `ammo10` int(10) NOT NULL DEFAULT 0,
  `ammo11` int(10) NOT NULL DEFAULT 0,
  `ammo12` int(10) NOT NULL DEFAULT 0,
  `golos` int(1) NOT NULL DEFAULT 0,
  `pistol_skill` int(10) NOT NULL DEFAULT 0,
  `sdpistol_skill` int(10) NOT NULL DEFAULT 0,
  `deagle_skill` int(10) NOT NULL DEFAULT 0,
  `shotgun_skill` int(10) NOT NULL DEFAULT 0,
  `mp5_skill` int(10) NOT NULL DEFAULT 0,
  `ak47_skill` int(10) NOT NULL DEFAULT 0,
  `rifle_skill` int(10) NOT NULL DEFAULT 0,
  `Respect` int(10) NOT NULL DEFAULT 0,
  `vip` int(1) NOT NULL DEFAULT 0,
  `time` int(10) NOT NULL DEFAULT 0,
  `podarok1` int(1) NOT NULL DEFAULT 0,
  `podarok2` int(1) NOT NULL DEFAULT 0,
  `podarok3` int(1) NOT NULL DEFAULT 0,
  `podarok4` int(1) NOT NULL DEFAULT 0,
  `podarok5` int(1) NOT NULL DEFAULT 0,
  `podarok6` int(1) NOT NULL DEFAULT 0,
  `podarok7` int(1) NOT NULL DEFAULT 0,
  `podarok8` int(1) NOT NULL DEFAULT 0,
  `contry` int(2) NOT NULL DEFAULT 0,
  `startx` float NOT NULL DEFAULT 0,
  `starty` float NOT NULL DEFAULT 0,
  `startz` float NOT NULL DEFAULT 0,
  `virti` int(20) NOT NULL DEFAULT 0,
  `virtw` int(20) NOT NULL DEFAULT 0,
  `reports` int(4) NOT NULL DEFAULT 0,
  `unicalcode` int(20) DEFAULT NULL,
  `twarn` int(1) NOT NULL DEFAULT 0,
  `medcard` int(11) NOT NULL DEFAULT 0,
  `kepka` varchar(80) NOT NULL,
  `kepkastatus` int(11) NOT NULL DEFAULT 0,
  `contenter` varchar(120) NOT NULL,
  `kopters` varchar(120) NOT NULL,
  `fixnabor` varchar(120) NOT NULL,
  `timerank` int(11) NOT NULL DEFAULT 0,
  `military` int(11) NOT NULL DEFAULT 0,
  `HIDEME` int(11) NOT NULL DEFAULT 0,
  `licnum` int(15) NOT NULL DEFAULT 0,
  `mednum` int(15) NOT NULL DEFAULT 0,
  `transfer` int(11) NOT NULL DEFAULT 0,
  `transfer_frac` int(11) NOT NULL DEFAULT 0,
  `transfer_rang` int(11) NOT NULL DEFAULT 0,
  `group` int(11) NOT NULL DEFAULT 0,
  `pstatus` int(11) DEFAULT 0,
  `groupid` int(11) NOT NULL DEFAULT 0,
  `ASACHAT` int(11) NOT NULL DEFAULT 0,
  `HEALPACKSKLAD` int(11) NOT NULL DEFAULT 0,
  `CaptureKills` int(11) NOT NULL DEFAULT 0,
  `bang` int(11) NOT NULL DEFAULT 0,
  `bangun` int(11) NOT NULL DEFAULT 0,
  `GID` int(11) NOT NULL DEFAULT -1,
  `uid` int(11) NOT NULL DEFAULT 0,
  `KILLFIST` int(11) NOT NULL DEFAULT 0,
  `pgive` int(11) NOT NULL DEFAULT 0,
  `ptime` int(11) NOT NULL DEFAULT 0,
  `CaptureValue` int(11) NOT NULL DEFAULT 0,
  `vkleader` int(11) NOT NULL DEFAULT -1,
  `promocode` int(11) NOT NULL DEFAULT 0,
  `version` varchar(32) NOT NULL,
  `vkid` int(50) NOT NULL DEFAULT 0,
  `usedrugs` int(11) NOT NULL,
  `admvig` int(11) NOT NULL,
  `Accessory_1` int(11) NOT NULL DEFAULT 0,
  `Accessory_2` int(11) NOT NULL DEFAULT 0,
  `Accessory_3` int(11) NOT NULL DEFAULT 0,
  `Accessory_4` int(11) NOT NULL DEFAULT 0,
  `UseAccessory` int(11) NOT NULL DEFAULT 0,
  `Accessory_5` int(11) NOT NULL DEFAULT 0,
  `Accessory_6` int(11) NOT NULL DEFAULT 0,
  `Accessory_7` int(11) NOT NULL DEFAULT 0,
  `Accessory_8` int(11) NOT NULL DEFAULT 0,
  `Accessory_9` int(11) NOT NULL DEFAULT 0,
  `Accessory_10` int(11) NOT NULL DEFAULT 0,
  `TakeAcs` int(11) NOT NULL DEFAULT 0,
  `AdminReports` int(11) NOT NULL DEFAULT 0,
  `AdminEvents` int(11) NOT NULL DEFAULT 0,
  `VKNotif` int(11) NOT NULL DEFAULT 1,
  `CarThiefValue` int(10) NOT NULL DEFAULT 0,
  `CarThiefLvl` int(10) NOT NULL DEFAULT 1,
  `ProgressMetall` int(11) NOT NULL DEFAULT 0,
  `ProgressDrugs` int(11) NOT NULL DEFAULT 0,
  `ProgressAmmo` int(11) NOT NULL DEFAULT 0,
  `ProgressCarGrabber` int(11) NOT NULL DEFAULT 0,
  `AntiCLMenu` int(10) NOT NULL,
  `ProgressSellGun` int(11) NOT NULL DEFAULT 0,
  `ProgressCapture` int(11) NOT NULL,
  `Status` int(10) NOT NULL,
  `AdminBot` int(11) NOT NULL,
  `Online` int(11) NOT NULL,
  `jail` int(10) NOT NULL DEFAULT 0,
  `jailtime` int(10) NOT NULL DEFAULT 0,
  `demorgan` int(10) NOT NULL DEFAULT 0,
  `demorgan_time` int(10) NOT NULL DEFAULT 0,
  `mute` int(10) NOT NULL DEFAULT 0,
  `mutetime` int(10) NOT NULL DEFAULT 0,
  `vmute` int(10) NOT NULL DEFAULT 0,
  `vmutetime` int(10) NOT NULL DEFAULT 0,
  `warn` int(10) NOT NULL DEFAULT 0,
  `warntime` int(10) NOT NULL DEFAULT 0,
  `PromoCodeUse` int(11) NOT NULL,
  `Сanister` int(11) NOT NULL DEFAULT 0,
  `CarGift` int(11) NOT NULL,
  `VkontakteID` int(11) NOT NULL DEFAULT 0,
  `VKCode` int(11) NOT NULL DEFAULT 0,
  `VKCodeStatus` int(11) NOT NULL DEFAULT 0,
  `TempVKID` int(11) NOT NULL,
  `TempVKName` varchar(50) NOT NULL,
  `AdminStatus` int(11) NOT NULL,
  `RankUPTime` int(11) NOT NULL,
  `CaptureManager` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `banlist`
--

CREATE TABLE `banlist` (
  `id` int(10) NOT NULL,
  `name` varchar(24) NOT NULL,
  `admin` varchar(24) NOT NULL,
  `day` int(2) NOT NULL,
  `text` varchar(100) NOT NULL,
  `ip` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `black_list`
--

CREATE TABLE `black_list` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `botvk`
--

CREATE TABLE `botvk` (
  `id` int(11) NOT NULL,
  `nick` varchar(32) NOT NULL,
  `leader_vch` varchar(32) NOT NULL DEFAULT 'нет',
  `leader_mvd` varchar(32) NOT NULL DEFAULT 'нет',
  `leader_bcrd` varchar(32) NOT NULL DEFAULT 'нет',
  `leader_pravo` varchar(32) NOT NULL DEFAULT 'нет',
  `leader_skinhead` varchar(32) NOT NULL DEFAULT 'нет',
  `leader_kavkaz` varchar(32) NOT NULL DEFAULT 'нет',
  `leader_gopota` varchar(32) NOT NULL DEFAULT 'нет',
  `leader_fsb` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_fsb` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_fsb1` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_vch` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_vch1` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_mvd` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_mvd1` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_mvd2` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_bcrd` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_bcrd1` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_pravo` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_pravo1` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_skinhead` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_skinhead1` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_kavkaz` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_kavkaz1` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_gopota` varchar(32) NOT NULL DEFAULT 'нет',
  `zam_gopota1` varchar(32) NOT NULL DEFAULT 'нет',
  `server` int(11) NOT NULL DEFAULT 1,
  `warn_pravo` int(11) NOT NULL DEFAULT 0,
  `warn_vch` int(11) NOT NULL DEFAULT 0,
  `warn_mvd` int(11) NOT NULL DEFAULT 0,
  `warn_bcrd` int(11) NOT NULL DEFAULT 0,
  `warn_skinhead` int(11) NOT NULL DEFAULT 0,
  `warn_gopota` int(11) NOT NULL DEFAULT 0,
  `warn_kavkaz` int(11) NOT NULL DEFAULT 0,
  `warn_fsb` int(11) NOT NULL DEFAULT 0,
  `onlinerecord` int(11) NOT NULL,
  `onlineday` int(11) NOT NULL,
  `onlinedayp` int(11) NOT NULL,
  `onlineweek` int(11) NOT NULL,
  `lastweek` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `business`
--

CREATE TABLE `business` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT 'none',
  `owner` varchar(24) NOT NULL DEFAULT 'none',
  `owned` int(1) NOT NULL DEFAULT 0,
  `price` int(10) NOT NULL DEFAULT 0,
  `enter_x` varchar(10) NOT NULL DEFAULT '0.0',
  `enter_y` varchar(10) NOT NULL DEFAULT '0.0',
  `enter_z` varchar(10) NOT NULL DEFAULT '0.0',
  `exit_x` varchar(10) NOT NULL DEFAULT '0.0',
  `exit_y` varchar(10) NOT NULL DEFAULT '0.0',
  `exit_z` varchar(10) NOT NULL DEFAULT '0.0',
  `exittp_x` float NOT NULL DEFAULT 0,
  `exittp_y` float NOT NULL DEFAULT 0,
  `exittp_z` float NOT NULL DEFAULT 0,
  `exittp_angle` float NOT NULL DEFAULT 0,
  `buy_x` varchar(10) NOT NULL DEFAULT '0.0',
  `buy_y` varchar(10) NOT NULL DEFAULT '0.0',
  `buy_z` varchar(10) NOT NULL DEFAULT '0.0',
  `prod` int(10) NOT NULL DEFAULT 0,
  `DayRent` int(3) NOT NULL DEFAULT 0,
  `RentCost` int(11) NOT NULL DEFAULT 25000,
  `SealedDays` int(11) NOT NULL DEFAULT -1,
  `type` int(1) NOT NULL DEFAULT 0,
  `lock` int(1) NOT NULL DEFAULT 0,
  `bank` int(10) NOT NULL DEFAULT 0,
  `price_prod` int(10) NOT NULL DEFAULT 0,
  `cena` int(10) NOT NULL DEFAULT 0,
  `vw` int(10) NOT NULL DEFAULT 0,
  `int` int(10) NOT NULL DEFAULT 0,
  `mapicon` int(10) NOT NULL DEFAULT 0,
  `clients` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `business`
--

INSERT INTO `business` (`id`, `name`, `owner`, `owned`, `price`, `enter_x`, `enter_y`, `enter_z`, `exit_x`, `exit_y`, `exit_z`, `exittp_x`, `exittp_y`, `exittp_z`, `exittp_angle`, `buy_x`, `buy_y`, `buy_z`, `prod`, `DayRent`, `RentCost`, `SealedDays`, `type`, `lock`, `bank`, `price_prod`, `cena`, `vw`, `int`, `mapicon`, `clients`) VALUES
(1, 'Магазин', 'None', 0, 850000, '1940.047', '2039.057', '15.869', '578.5307', '86.9487', '382.6700', 1939.8, 2041.37, 15.879, 4.605, '582.0419', '80.4531', '382.6700', -50, 0, 25000, -1, 2, 0, 0, 6, 10, 1, 1, 38, 0),
(2, 'Магазин', 'None', 1, 850000, '1949.891', '1899.305', '15.512', '578.5307', '86.9487', '382.6700', 1952.83, 1899.05, 15.512, 269.661, '582.0419', '80.4531', '382.6700', 43, 5, 25000, -1, 2, 0, 10279405, 6, 0, 2, 1, 38, 0),
(3, 'Магазин одежды', 'None', 0, 1050000, '1945.619', '2069.135', '16.199', '204.666', '872.082', '1019.15', 1945.5, 2066.21, 15.705, 179.127, '206.215', '868.552', '1019.12', -18, 0, 25000, 2, 3, 0, 7783245, 3, 0, 3, 1, 45, 0),
(4, 'Магазин', 'None', 0, 850000, '1851.051', '2246.015', '15.617', '578.5307', '86.9487', '382.6700', 1854.53, 2246.01, 15.273, 270.366, '582.0419', '80.4531', '382.6700', -30, -1, 25000, 2, 2, 0, 0, 6, 0, 4, 1, 38, 0),
(9, 'Магазин', 'None', 0, 850000, '1867.715', '1383.054', '9.799', '578.5307', '86.9487', '382.6700', 1870.63, 1383.18, 9.769, 269.393, '582.0419', '80.4531', '382.6700', 97, 0, 25000, -1, 2, 0, 0, 6, 0, 9, 1, 38, 0),
(12, 'Магазин', 'None', 0, 850000, '-448.021', '-1473.46', '41.067', '578.5307', '86.9487', '382.6700', -446.452, -1474.36, 41.067, 248.639, '582.0419', '80.4531', '382.6700', 0, -1, 25000, 2, 2, 0, 0, 6, 0, 12, 1, 38, 0),
(16, 'АЗС', 'None', 1, 600000, '1708.076', '1296.427', '11.709', '1708.076', '1296.427', '11.709', 1708.08, 1296.43, 11.709, 216.373, '1708.076', '1296.427', '11.709', 17, 3, 25000, -1, 1, 0, 10856018, 4, 10, 0, 0, 47, 0),
(17, 'Магазин', 'None', 0, 850000, '-437.389', '-1456.508', '41.07', '578.5307', '86.9487', '382.6700', -434.816, -1458.32, 41.07, 235.066, '582.0419', '80.4531', '382.6700', 0, 22, 25000, -1, 2, 0, 6460346, 6, 0, 13, 1, 38, 0),
(18, 'АЗС', 'None', 0, 600000, '2247.393', '-1785.413', '21.348', '2247.393', '-1785.413', '21.348', 2247.33, -1785.41, 21.358, 282.272, '2247.393', '-1785.413', '21.348', -30, 0, 25000, 2, 1, 0, 619427, 4, 10, 0, 0, 47, 0),
(19, 'Магазин', 'None', 0, 850000, '2304.604', '-2090.677', '22.137', '578.5307', '86.9487', '382.6700', 2302.3, -2090.57, 21.98, 90.497, '582.0419', '80.4531', '382.6700', 59, -1, 25000, 2, 2, 0, 0, 6, 0, 15, 1, 38, 0),
(20, 'Магазин', 'None', 0, 850000, '2623.087', '-2466.722', '22.469', '578.5307', '86.9487', '382.6700', 2619.9, -2466.58, 22.016, 88.543, '582.0419', '80.4531', '382.6700', -29, -1, 25000, 2, 2, 0, 0, 6, 0, 16, 1, 38, 0),
(22, 'Магазин одежды', 'None', 0, 1050000, '1670.089', '2231.948', '14.876', '204.666', '872.082', '1019.15', 1672.16, 2232.18, 14.423, 271.392, '206.215', '868.552', '1019.12', 164, 0, 25000, 2, 3, 0, 12102084, 3, 0, 18, 1, 45, 0),
(23, 'Магазин', 'None', 0, 850000, '2261.186', '-636.195', '12.364', '578.5307', '86.9487', '382.6700', 2261.33, -639.043, 12.07, 176.385, '582.0419', '80.4531', '382.6700', -45, 0, 25000, 2, 2, 0, 55191787, 6, 0, 19, 1, 38, 0),
(24, 'Магазин одежды', 'None', 0, 1050000, '2288.445', '-636.055', '12.364', '204.666', '872.082', '1019.15', 2288.21, -638.004, 12.07, 176.749, '206.215', '868.552', '1019.12', 104, 0, 25000, -1, 3, 0, 0, 3, 0, 20, 1, 45, 0),
(25, 'Магазин', 'None', 1, 850000, '2231.727', '-636.055', '12.364', '578.5307', '86.9487', '382.6700', 2231.61, -637.911, 12.07, 175.793, '582.0419', '80.4531', '382.6700', 29, 4, 25000, -1, 2, 0, 11244445, 6, 0, 21, 1, 38, 0),
(26, 'Магазин', 'None', 0, 850000, '2227.647', '-551.644', '12.085', '578.5307', '86.9487', '382.6700', 2227.41, -554.486, 12.07, 178.251, '582.0419', '80.4531', '382.6700', 75, 0, 25000, -1, 2, 0, 0, 6, 0, 22, 1, 38, 1),
(27, 'АЗС', 'None', 0, 600000, '2370.861', '-779.288', '12.2', '2370.861', '-779.288', '12.2', 2370.86, -779.288, 12.2, 273.165, '2370.861', '-779.288', '12.2', -4, -1, 25000, 1, 1, 0, 0, 4, 10, 0, 0, 47, 0),
(28, 'АЗС', 'None', 1, 600000, '2230.917', '3983.193', '2.402', '2230.917', '3983.193', '2.402', 2230.6, 3983.7, 2.405, 308.702, '2230.917', '3983.193', '2.402', 92, 3, 25000, -1, 1, 0, 9610345, 4, 10, 0, 0, 47, 0),
(29, 'Автосалон', 'None', 0, 1500000, '2328.641', '-1804.083', '22.454', '0.0', '0.0', '0.0', 2326.24, -1803.96, 22.454, 89.313, '0.0', '0.0', '0.0', -36, 0, 25000, 3, 6, 0, 1506983, 0, 0, 24, 17, 29, 0),
(30, 'Магазин', 'None', 0, 1500000, '1981.021', '1893.287', '15.528', '578.531', '86.949', '382.67', 1977.02, 1893.2, 15.528, 93.382, '582.042', '80.453', '382.67', 10, 0, 25000, 2, 2, 0, 15499233, 6, 0, 25, 1, 38, 0),
(32, 'Магазин', 'None', 0, 5000000, '2231.56', '3996.104', '2.463', '578.531', '86.949', '382.67', 2236.94, 3991.63, 2.463, 172.815, '582.042', '80.453', '382.67', -6, -1, 25000, 2, 2, 0, 0, 6, 0, 27, 1, 38, 4),
(36, 'Магазин', 'None', 0, 5000000, '2069.289', '1815.69', '12.679', '578.531', '86.949', '382.67', 2072.29, 1815.11, 12.225, 273.515, '582.042', '80.453', '382.67', -160, 0, 25000, 1, 2, 0, 13042991, 6, 0, 30, 1, 38, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `business_fin`
--

CREATE TABLE `business_fin` (
  `id` int(11) NOT NULL,
  `bussines_id` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `people` int(11) NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `donate`
--

CREATE TABLE `donate` (
  `id` int(11) NOT NULL,
  `nick` varchar(100) NOT NULL,
  `sum` int(11) NOT NULL,
  `give` int(11) NOT NULL,
  `status` varchar(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `fractions_blacklist`
--

CREATE TABLE `fractions_blacklist` (
  `bl_player` int(6) NOT NULL,
  `bl_fraction` int(6) NOT NULL,
  `bl_name` varchar(64) NOT NULL,
  `bl_day` int(11) NOT NULL,
  `bl_reason` varchar(64) NOT NULL,
  `bl_dob` varchar(64) NOT NULL,
  `bl_rank` varchar(64) NOT NULL,
  `bl_id` int(11) NOT NULL,
  `bl_name2` varchar(64) NOT NULL,
  `id_bl` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `freekassa_payments`
--

CREATE TABLE `freekassa_payments` (
  `id` int(10) NOT NULL,
  `freekassaId` varchar(255) NOT NULL,
  `account` varchar(255) NOT NULL,
  `sum` float NOT NULL,
  `itemsCount` int(11) NOT NULL DEFAULT 1,
  `dateCreate` datetime NOT NULL,
  `dateComplete` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `gangzone`
--

CREATE TABLE `gangzone` (
  `gzid` int(3) NOT NULL,
  `gzminx` double NOT NULL,
  `gzminy` double NOT NULL,
  `gzmaxx` double NOT NULL,
  `gzmaxy` double NOT NULL,
  `gzopg` int(1) NOT NULL,
  `standart_team` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `gangzone`
--

INSERT INTO `gangzone` (`gzid`, `gzminx`, `gzminy`, `gzmaxx`, `gzmaxy`, `gzopg`, `standart_team`) VALUES
(1, 2590.1669921875, 1738.1666259765625, 2696.1669921875, 1802.1666259765625, 5, 5),
(2, 2590.1669921875, 1802.1666259765625, 2696.1669921875, 1866.1666259765625, 5, 5),
(3, 2590.1669921875, 1866.1666259765625, 2696.1669921875, 1930.1666259765625, 5, 5),
(4, 2484.1669921875, 1866.1666259765625, 2590.1669921875, 1930.1666259765625, 5, 5),
(5, 2484.1669921875, 1802.1666259765625, 2590.1669921875, 1866.1666259765625, 5, 5),
(6, 2249.1669921875, 1802.1666259765625, 2484.1669921875, 1930.1666259765625, 5, 5),
(7, 2143.1669921875, 1866.1666564941406, 2249.1669921875, 1930.1666564941406, 5, 5),
(8, 2143.1669921875, 1802.1666564941406, 2249.1669921875, 1866.1666564941406, 5, 5),
(9, 2036.1669921875, 1802.1666564941406, 2142.1669921875, 1866.1666564941406, 5, 5),
(10, 2035.1484375, 1866.171875, 2143.1484375, 1930.171875, 5, 5),
(11, 1930.1669921875, 1867.1666564941406, 2035.1669921875, 1930.1666564941406, 5, 5),
(12, 1930.1669921875, 1802.1666564941406, 2036.1669921875, 1866.1666564941406, 5, 5),
(13, 1825.1669921875, 1867.1666564941406, 1930.1669921875, 1930.1666564941406, 5, 5),
(14, 1825.1669921875, 1803.1666564941406, 1930.1669921875, 1866.1666564941406, 5, 5),
(15, 1824.1669921875, 1930.1666564941406, 2036.1669921875, 2014.1666564941406, 5, 5),
(16, 1824.1669921875, 2014.1666564941406, 2036.1669921875, 2097.1666564941406, 5, 5),
(17, 1824.1669921875, 2097.1666564941406, 2036.1669921875, 2181.1666564941406, 5, 5),
(18, 1824.1669921875, 2181.1666564941406, 2036.1669921875, 2265.1666564941406, 5, 5),
(19, 1824.1669921875, 2265.1666564941406, 2036.1669921875, 2349.1666564941406, 5, 5),
(20, 1672.1669921875, 2265.1666412353516, 1824.1669921875, 2349.1666412353516, 5, 5),
(21, 1672.1669921875, 2181.1666412353516, 1824.1669921875, 2265.1666412353516, 5, 5),
(22, 1672.1669921875, 2097.1666412353516, 1824.1669921875, 2181.1666412353516, 5, 5),
(23, 1672.1669921875, 2013.1666412353516, 1824.1669921875, 2097.1666412353516, 5, 5),
(24, 1672.1669921875, 1929.1666412353516, 1824.1669921875, 2013.1666412353516, 5, 5),
(25, 1672.1669921875, 1802.1666259765625, 1825.1669921875, 1929.1666259765625, 5, 5),
(26, 1672.1669921875, 1673.1666259765625, 2037.1669921875, 1802.1666259765625, 5, 5),
(27, 1672.1669921875, 1544.1666259765625, 2037.1669921875, 1673.1666259765625, 5, 5),
(28, 1307.1669921875, 1673.1666259765625, 1672.1669921875, 1802.1666259765625, 5, 5),
(29, 1307.1669921875, 1544.1666259765625, 1672.1669921875, 1673.1666259765625, 5, 5),
(30, 1003.1668395996094, 1544.1666259765625, 1306.1668395996094, 1673.1666259765625, 5, 5),
(31, 1003.1668395996094, 1673.1666259765625, 1306.1668395996094, 1802.1666259765625, 5, 5),
(32, 1672.1669921875, 1415.1666259765625, 2037.1669921875, 1544.1666259765625, 5, 5),
(33, 1672.1669921875, 1286.1666259765625, 2037.1669921875, 1415.1666259765625, 5, 5),
(34, 1683.8336791992188, -2708.5001831054688, 1911.8336791992188, -2605.5001831054688, 6, 6),
(35, 1911.8336791992188, -2709.5001831054688, 2139.8336791992188, -2605.5001831054688, 6, 6),
(36, 2139.833740234375, -2709.5001831054688, 2367.833740234375, -2605.5001831054688, 6, 6),
(37, 2367.833740234375, -2709.5001831054688, 2595.833740234375, -2605.5001831054688, 6, 6),
(38, 2595.833740234375, -2709.5001831054688, 2823.833740234375, -2605.5001831054688, 6, 6),
(39, 2595.833740234375, -2605.5001831054688, 2823.833740234375, -2501.5001831054688, 6, 6),
(40, 2367.8336791992188, -2605.5001831054688, 2595.8336791992188, -2501.5001831054688, 6, 6),
(41, 2139.8336791992188, -2605.5001831054688, 2367.8336791992188, -2501.5001831054688, 6, 6),
(42, 1911.8336791992188, -2605.5001831054688, 2139.8336791992188, -2501.5001831054688, 6, 6),
(43, 1683.8336791992188, -2605.5001831054688, 1911.8336791992188, -2501.5001831054688, 6, 6),
(44, 1683.8336791992188, -2501.5003662109375, 1911.8336791992188, -2397.5003662109375, 6, 6),
(45, 1911.8336791992188, -2501.5003662109375, 2139.8336791992188, -2397.5003662109375, 6, 6),
(46, 2139.833740234375, -2501.5003662109375, 2367.833740234375, -2397.5003662109375, 6, 6),
(47, 2367.833740234375, -2501.5003662109375, 2595.833740234375, -2397.5003662109375, 6, 6),
(48, 2595.833740234375, -2501.5003662109375, 2823.833740234375, -2397.5003662109375, 6, 6),
(49, 2595.833740234375, -2397.5003356933594, 2823.833740234375, -2293.5003356933594, 6, 6),
(50, 2367.8336791992188, -2397.5003356933594, 2595.8336791992188, -2293.5003356933594, 6, 6),
(51, 2139.8336791992188, -2397.5003356933594, 2367.8336791992188, -2293.5003356933594, 6, 6),
(52, 1911.8336791992188, -2397.5003356933594, 2139.8336791992188, -2293.5003356933594, 6, 6),
(53, 1683.8336791992188, -2397.5003356933594, 1911.8336791992188, -2293.5003356933594, 6, 6),
(54, 1683.8336791992188, -2293.5003356933594, 1911.8336791992188, -2189.5003356933594, 6, 6),
(55, 1911.8336791992188, -2293.5003356933594, 2139.8336791992188, -2189.5003356933594, 6, 6),
(56, 2139.833740234375, -2293.5003356933594, 2367.833740234375, -2189.5003356933594, 6, 6),
(57, 2367.833740234375, -2293.5003356933594, 2595.833740234375, -2189.5003356933594, 6, 6),
(58, 2595.833740234375, -2293.5003356933594, 2823.833740234375, -2189.5003356933594, 6, 6),
(59, 2139.8336791992188, -2189.5001831054688, 2823.8336791992188, -2058.5001831054688, 6, 6),
(60, 1911.8336791992188, -2058.5, 2139.8336791992188, -1927.5, 6, 6),
(61, 1911.8336791992188, -2189.5, 2139.8336791992188, -2058.5, 6, 6),
(62, 1683.8336791992188, -2189.5003662109375, 1911.8336791992188, -2058.5003662109375, 6, 6),
(63, 2139.8336791992188, -2058.5001831054688, 2823.8336791992188, -1927.5001831054688, 6, 6),
(64, 2139.8336791992188, -1927.5001831054688, 2823.8336791992188, -1796.5001831054688, 6, 6),
(65, 1911.8333740234375, -1927.5, 2139.8333740234375, -1796.5, 6, 6),
(66, 2139.8333740234375, -1795.5, 2823.8333740234375, -1664.5, 6, 6),
(67, 2139.8333740234375, -1663.5003356933594, 2823.8333740234375, -1532.5003356933594, 6, 6),
(68, -671.833251953125, -1671.166748046875, -614.833251953125, -1571.166748046875, 7, 7),
(69, -614.833251953125, -1671.166748046875, -557.833251953125, -1571.166748046875, 7, 7),
(70, -557.833251953125, -1671.166748046875, -500.833251953125, -1571.166748046875, 7, 7),
(71, -501.833251953125, -1671.166748046875, -444.833251953125, -1571.166748046875, 7, 7),
(72, -445.833251953125, -1671.166748046875, -388.833251953125, -1571.166748046875, 7, 7),
(73, -389.833251953125, -1671.166748046875, -332.833251953125, -1571.166748046875, 7, 7),
(74, -333.833251953125, -1671.166748046875, -276.833251953125, -1571.166748046875, 7, 7),
(75, -333.833251953125, -1571.166748046875, -276.833251953125, -1471.166748046875, 7, 7),
(76, -389.833251953125, -1571.166748046875, -332.833251953125, -1471.166748046875, 7, 7),
(77, -445.833251953125, -1571.166748046875, -388.833251953125, -1471.166748046875, 7, 7),
(78, -501, -1571.166748046875, -444.833251953125, -1471.166748046875, 7, 7),
(79, -557.833251953125, -1571.1668701171875, -501.833251953125, -1471.1668701171875, 7, 7),
(80, -614.833251953125, -1571.166748046875, -557.833251953125, -1471.166748046875, 7, 7),
(81, -671.833251953125, -1571.166748046875, -614.833251953125, -1471.166748046875, 7, 7),
(82, -671.833251953125, -1471.166748046875, -614.833251953125, -1371.166748046875, 7, 7),
(83, -614.833251953125, -1471.166748046875, -558.833251953125, -1371.166748046875, 7, 7),
(84, -558.833251953125, -1471.166748046875, -500.833251953125, -1371.166748046875, 7, 7),
(85, -501.833251953125, -1471.166748046875, -444.833251953125, -1371.166748046875, 7, 7),
(86, -445.833251953125, -1471.166748046875, -388.833251953125, -1371.166748046875, 7, 7),
(87, -389.833251953125, -1471.166748046875, -332.833251953125, -1371.166748046875, 7, 7),
(88, -333.833251953125, -1471.166748046875, -276.833251953125, -1371.166748046875, 7, 7),
(89, -558.833251953125, -1371.1668395996094, -502.833251953125, -1271.1668395996094, 7, 7),
(90, -502.833251953125, -1371.1668395996094, -444.833251953125, -1271.1668395996094, 7, 7),
(91, -445.833251953125, -1371.1668395996094, -389.833251953125, -1271.1668395996094, 7, 7),
(92, -614.833251953125, -1371.1668395996094, -558.833251953125, -1271.1668395996094, 7, 7),
(93, -389.833251953125, -1371.1668395996094, -333.833251953125, -1271.1668395996094, 7, 7),
(94, -333.833251953125, -1371.1668395996094, -277.833251953125, -1271.1668395996094, 7, 7),
(95, -277.833251953125, -1371.1668395996094, -221.833251953125, -1271.1668395996094, 7, 7),
(96, -221.833251953125, -1371.1668395996094, -163.833251953125, -1271.1668395996094, 7, 7),
(97, -277.833251953125, -1271.1668395996094, -221.833251953125, -1171.1668395996094, 7, 7),
(98, -221.833251953125, -1270.1668395996094, -164.833251953125, -1171.1668395996094, 7, 7),
(99, -501.833251953125, -1771.166748046875, -443.833251953125, -1671.166748046875, 7, 7),
(100, -557.833251953125, -1771.166748046875, -499.833251953125, -1671.166748046875, 7, 7),
(101, 1449.5, -1355, 1591.5, -1133, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `group`
--

CREATE TABLE `group` (
  `id` int(11) NOT NULL,
  `fraction` int(11) NOT NULL,
  `group_name` varchar(50) NOT NULL,
  `skin_m` int(11) NOT NULL,
  `skin_g` int(11) NOT NULL,
  `standart` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `houses`
--

CREATE TABLE `houses` (
  `id` int(10) NOT NULL,
  `enterx` float NOT NULL DEFAULT 0,
  `entery` float NOT NULL DEFAULT 0,
  `enterz` float NOT NULL DEFAULT 0,
  `exitx` float NOT NULL DEFAULT 0,
  `exity` float NOT NULL DEFAULT 0,
  `exitz` float NOT NULL DEFAULT 0,
  `carx` float NOT NULL DEFAULT 0,
  `cary` float NOT NULL DEFAULT 0,
  `carz` float NOT NULL DEFAULT 0,
  `cara` float NOT NULL DEFAULT 0,
  `price` int(20) NOT NULL,
  `owner` varchar(24) DEFAULT NULL,
  `lock` int(1) NOT NULL DEFAULT 1,
  `owned` int(1) DEFAULT NULL,
  `class` int(11) NOT NULL DEFAULT 0,
  `day` int(11) DEFAULT NULL,
  `int` int(10) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `houses`
--

INSERT INTO `houses` (`id`, `enterx`, `entery`, `enterz`, `exitx`, `exity`, `exitz`, `carx`, `cary`, `carz`, `cara`, `price`, `owner`, `lock`, `owned`, `class`, `day`, `int`) VALUES
(1, 1985.88, 1831.92, 16.111, 1113.18, 1526.15, 905.804, 1983.74, 1834.95, 15.512, 83.041, 2000000, 'none', 1, 1, 4, 21, 2),
(2, 1989.36, 1793.94, 15.739, 1113.18, 1526.15, 905.804, 1986.98, 1794.05, 15.534, 89.413, 2000000, 'none', 1, 0, 4, 1, 2),
(3, 1995, 1746.17, 15.692, 1113.18, 1526.15, 905.804, 1992.78, 1745.71, 15.692, 89.758, 2000000, 'none', 0, 1, 4, 18, 2),
(4, 1943.53, 1752.95, 15.357, 1113.18, 1526.15, 905.804, 1945.64, 1753.61, 15.356, 273.04, 2000000, 'none', 1, 1, 2000000, 19, 2),
(5, 2145.13, 3996.08, 3.881, 1113.18, 1526.15, 905.804, 2144.43, 3993.43, 3.881, 171.495, 10000000, 'none', 1, 0, 4, 1, 1),
(6, 2325.05, 3980.23, 3.991, 1113.18, 1526.15, 905.804, 2325.12, 3975.69, 3.991, 179.755, 10000000, 'none', 1, 0, 4, 1, 1),
(7, 1943.5, 1806.77, 15.702, 1113.18, 1526.15, 905.804, 1943.53, 1809.05, 15.448, 1.947, 3000000, 'none', 0, 1, 4, 20, 1),
(8, 2113.13, 3935.86, 3.382, 1113.18, 1526.15, 905.804, 2116.66, 3935.19, 2.32, 266.69, 5000000, 'none', 1, 0, 4, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `kvartiry`
--

CREATE TABLE `kvartiry` (
  `id` int(10) NOT NULL,
  `owner1` varchar(24) NOT NULL DEFAULT 'none',
  `owner2` varchar(24) NOT NULL DEFAULT 'none',
  `owner3` varchar(24) NOT NULL DEFAULT 'none',
  `owner4` varchar(24) NOT NULL DEFAULT 'none',
  `owner5` varchar(24) NOT NULL DEFAULT 'none',
  `owner6` varchar(24) NOT NULL DEFAULT 'none',
  `owned1` int(1) NOT NULL DEFAULT 0,
  `owned2` int(1) NOT NULL DEFAULT 0,
  `owned3` int(1) NOT NULL DEFAULT 0,
  `owned4` int(1) NOT NULL DEFAULT 0,
  `owned5` int(1) NOT NULL DEFAULT 0,
  `owned6` int(1) NOT NULL DEFAULT 0,
  `enter_x1` float NOT NULL DEFAULT 630.125,
  `enter_y1` float NOT NULL DEFAULT -168.712,
  `enter_z1` float NOT NULL DEFAULT 1002.82,
  `enter_x2` float NOT NULL DEFAULT 630.089,
  `enter_y2` float NOT NULL DEFAULT -165.891,
  `enter_z2` float NOT NULL DEFAULT 1002.82,
  `enter_x3` float NOT NULL DEFAULT 630.118,
  `enter_y3` float NOT NULL DEFAULT -168.707,
  `enter_z3` float NOT NULL DEFAULT 1006.91,
  `enter_x4` float NOT NULL DEFAULT 630.153,
  `enter_y4` float NOT NULL DEFAULT -165.893,
  `enter_z4` float NOT NULL DEFAULT 1006.91,
  `enter_x5` float NOT NULL DEFAULT 630.104,
  `enter_y5` float NOT NULL DEFAULT -168.707,
  `enter_z5` float NOT NULL DEFAULT 1011,
  `enter_x6` float NOT NULL DEFAULT 630.15,
  `enter_y6` float NOT NULL DEFAULT -165.877,
  `enter_z6` float NOT NULL DEFAULT 1011,
  `exit_x1` float NOT NULL DEFAULT -625.064,
  `exit_y1` float NOT NULL DEFAULT 79.0075,
  `exit_z1` float NOT NULL DEFAULT 1003.36,
  `exit_x2` float NOT NULL DEFAULT 647.669,
  `exit_y2` float NOT NULL DEFAULT -12.024,
  `exit_z2` float NOT NULL DEFAULT 1001.43,
  `exit_x3` float NOT NULL DEFAULT 574.747,
  `exit_y3` float NOT NULL DEFAULT -1.1061,
  `exit_z3` float NOT NULL DEFAULT 1001.48,
  `exit_x4` float NOT NULL DEFAULT 574.747,
  `exit_y4` float NOT NULL DEFAULT -1.1061,
  `exit_z4` float NOT NULL DEFAULT 1001.48,
  `exit_x5` float NOT NULL DEFAULT -625.064,
  `exit_y5` float NOT NULL DEFAULT 79.0075,
  `exit_z5` float NOT NULL DEFAULT 1003.36,
  `exit_x6` float NOT NULL DEFAULT 647.669,
  `exit_y6` float NOT NULL DEFAULT -12.024,
  `exit_z6` float NOT NULL DEFAULT 1001.43,
  `enter_x` float NOT NULL DEFAULT 0,
  `enter_y` float NOT NULL DEFAULT 0,
  `enter_z` float NOT NULL DEFAULT 0,
  `exit_x` float NOT NULL DEFAULT 630.345,
  `exit_y` float NOT NULL DEFAULT -178.275,
  `exit_z` float NOT NULL DEFAULT 997.004,
  `price1` int(10) NOT NULL DEFAULT 150000,
  `price2` int(10) NOT NULL DEFAULT 400000,
  `price3` int(10) NOT NULL DEFAULT 750000,
  `price4` int(10) NOT NULL DEFAULT 750000,
  `price5` int(10) NOT NULL DEFAULT 150000,
  `price6` int(10) NOT NULL DEFAULT 400000,
  `car_posx` float NOT NULL DEFAULT 0,
  `car_posy` float NOT NULL DEFAULT 0,
  `car_posz` float NOT NULL DEFAULT 0,
  `car_posa` float NOT NULL DEFAULT 0,
  `class1` int(1) NOT NULL DEFAULT 0,
  `class2` int(1) NOT NULL DEFAULT 1,
  `class3` int(1) NOT NULL DEFAULT 2,
  `class4` int(1) NOT NULL DEFAULT 2,
  `class5` int(1) NOT NULL DEFAULT 0,
  `class6` int(1) NOT NULL DEFAULT 1,
  `lock1` int(10) NOT NULL DEFAULT 0,
  `lock2` int(10) NOT NULL DEFAULT 0,
  `lock3` int(10) NOT NULL DEFAULT 0,
  `lock4` int(10) NOT NULL DEFAULT 0,
  `lock5` int(10) NOT NULL DEFAULT 0,
  `lock6` int(10) NOT NULL DEFAULT 0,
  `day1` int(10) NOT NULL DEFAULT 0,
  `day2` int(10) NOT NULL DEFAULT 0,
  `day3` int(10) NOT NULL DEFAULT 0,
  `day4` int(10) NOT NULL DEFAULT 0,
  `day5` int(10) NOT NULL DEFAULT 0,
  `day6` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `kvartiry`
--

INSERT INTO `kvartiry` (`id`, `owner1`, `owner2`, `owner3`, `owner4`, `owner5`, `owner6`, `owned1`, `owned2`, `owned3`, `owned4`, `owned5`, `owned6`, `enter_x1`, `enter_y1`, `enter_z1`, `enter_x2`, `enter_y2`, `enter_z2`, `enter_x3`, `enter_y3`, `enter_z3`, `enter_x4`, `enter_y4`, `enter_z4`, `enter_x5`, `enter_y5`, `enter_z5`, `enter_x6`, `enter_y6`, `enter_z6`, `exit_x1`, `exit_y1`, `exit_z1`, `exit_x2`, `exit_y2`, `exit_z2`, `exit_x3`, `exit_y3`, `exit_z3`, `exit_x4`, `exit_y4`, `exit_z4`, `exit_x5`, `exit_y5`, `exit_z5`, `exit_x6`, `exit_y6`, `exit_z6`, `enter_x`, `enter_y`, `enter_z`, `exit_x`, `exit_y`, `exit_z`, `price1`, `price2`, `price3`, `price4`, `price5`, `price6`, `car_posx`, `car_posy`, `car_posz`, `car_posa`, `class1`, `class2`, `class3`, `class4`, `class5`, `class6`, `lock1`, `lock2`, `lock3`, `lock4`, `lock5`, `lock6`, `day1`, `day2`, `day3`, `day4`, `day5`, `day6`) VALUES
(1, 'none', 'none', 'None', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1793.51, 2400.41, 15.31, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1791.04, 2398.7, 15.269, 121.395, 0, 1, 2, 2, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0),
(2, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1787.67, 2409.34, 15.318, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1785.39, 2408.1, 15.268, 120.036, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0),
(3, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1777.76, 2384.49, 15.27, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1780.49, 2386.41, 15.271, 303.87, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(4, 'none', 'none', 'None', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1771.59, 2393.3, 15.279, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1773.28, 2394.46, 15.272, 297.279, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0),
(5, 'none', 'none', 'none', 'none', 'none', 'none', 1, 0, 0, 0, 1, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1767.08, 2428.82, 15.359, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1764.56, 2427.36, 15.359, 122.198, 0, 1, 2, 2, 0, 1, 1, 0, 0, 0, 0, 0, 21, 1, 1, 0, 2, 0),
(25, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, -369.551, -1417.2, 41.443, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, -371.92, -1420.31, 41.203, 146.304, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
(26, 'none', 'none', 'none', 'none', 'None', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2242.73, -2550.42, 22.336, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2242.79, -2553.47, 21.973, 181.515, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0),
(27, 'none', 'none', 'none', 'none', 'none', 'none', 1, 0, 1, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2325.49, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2325.33, -2475.62, 21.942, 178.471, 0, 1, 2, 2, 0, 1, 0, 0, 0, 1, 0, 0, 15, 1, 11, 1, 1, 0),
(28, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2349.53, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2349.46, -2475.56, 21.942, 178.745, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2385.17, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2385, -2475.96, 21.95, 178.851, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(30, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2409.11, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2409.12, -2475.47, 21.942, 180.508, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(31, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2433.17, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2433.31, -2475.59, 21.942, 180.731, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2301.38, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2301.32, -2475.68, 21.95, 181.017, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(33, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2265.6, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2265.47, -2475.63, 21.942, 178.287, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(34, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2241.61, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2241.03, -2476.25, 21.942, 179.212, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0),
(35, 'None', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2217.47, -2473.08, 22.839, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2217.36, -2475.76, 21.95, 177.621, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0),
(36, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1740.3, -2324.43, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1737.21, -2324.6, 11.001, 87.605, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0),
(37, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1740.3, -2348.68, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1737.79, -2348.36, 11.001, 83.99, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(38, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1740.28, -2372.48, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1738.24, -2372.38, 11.001, 88.467, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1780.13, -2416.39, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1777.13, -2416.33, 11.001, 85.753, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1780.13, -2440.3, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1777.51, -2440.4, 11.001, 89.172, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1780.12, -2464.51, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1778.14, -2464.22, 11.001, 86.47, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1819.69, -2508.38, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1816.94, -2508.14, 11.001, 89.904, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1819.69, -2532.35, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1816.7, -2532.47, 11.001, 87.566, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(44, 'none', 'none', 'none', 'none', 'none', 'none', 0, 1, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1819.68, -2556.36, 11.405, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1816.74, -2556.33, 11.001, 90.296, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 20, 0, 0, 0, 0),
(45, 'none', 'none', 'none', 'none', 'none', 'none', 1, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2335.97, -2027.45, 22.101, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2339.63, -2027.39, 21.978, 270.934, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 20, 1, 1, 1, 1, 0),
(46, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2335.97, -2046.19, 22.101, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2338.84, -2046.16, 21.97, 269.765, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0),
(47, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2335.97, -2064.7, 22.101, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2338.42, -2064.71, 21.978, 268.858, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, 'None', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2335.97, -2083.29, 22.101, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2339.58, -2083.33, 21.978, 268.607, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(49, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2401.21, -2115.65, 22.12, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2403.8, -2115.8, 21.978, 267.573, 0, 1, 2, 2, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0),
(50, 'none', 'none', 'none', 'none', 'none', 'none', 1, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2443.09, -2115.65, 22.12, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2440.12, -2115.86, 21.978, 93.202, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 13, 1, 1, 1, 0, 0),
(51, 'none', 'none', 'None', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2436.4, -2131.9, 22.12, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2436.36, -2129.24, 21.978, 3.431, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0),
(60, 'none', 'none', 'none', 'None', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1789.49, 2201.64, 15.621, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1789.34, 2199.02, 15.675, 176.888, 0, 1, 2, 2, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0),
(61, 'none', 'none', 'None', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1800.16, 2201.64, 15.625, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1800.08, 2199.85, 15.633, 178.259, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0),
(62, 'none', 'none', 'None', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1790.48, 2179.45, 15.992, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1792.81, 2179.41, 15.987, 268.813, 0, 1, 2, 2, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0),
(63, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1790.48, 2163.05, 15.992, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1793.26, 2163.03, 15.977, 267.571, 0, 1, 2, 2, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0),
(64, 'none', 'none', 'none', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 2268.21, -1705.06, 22.197, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 2271.62, -1705.12, 21.962, 270.125, 0, 1, 2, 2, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0),
(66, 'none', 'none', 'None', 'none', 'none', 'none', 0, 0, 0, 0, 0, 0, 630.125, -168.712, 1002.82, 630.089, -165.891, 1002.82, 630.118, -168.707, 1006.91, 630.153, -165.893, 1006.91, 630.104, -168.707, 1011, 630.15, -165.877, 1011, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 574.747, -1.1061, 1001.48, 574.747, -1.1061, 1001.48, -625.064, 79.0075, 1003.36, 647.669, -12.024, 1001.43, 1859.48, 2164.64, 15.937, 630.345, -178.275, 997.004, 150000, 400000, 750000, 750000, 150000, 400000, 1857.1, 2198.56, 15.945, 89.186, 0, 1, 2, 2, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `log_paymoney`
--

CREATE TABLE `log_paymoney` (
  `id` int(100) NOT NULL,
  `name` varchar(24) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(10) NOT NULL,
  `text` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `log_player`
--

CREATE TABLE `log_player` (
  `id` int(100) NOT NULL,
  `name` varchar(24) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(10) NOT NULL,
  `text` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `log_transfermoney`
--

CREATE TABLE `log_transfermoney` (
  `id` int(100) NOT NULL,
  `name` varchar(24) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(10) NOT NULL,
  `text` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `nickname_history`
--

CREATE TABLE `nickname_history` (
  `nh_owner` int(11) NOT NULL,
  `nh_oldname` varchar(32) NOT NULL,
  `nh_newname` varchar(32) NOT NULL,
  `nh_date` text NOT NULL,
  `nh_admin` text NOT NULL,
  `day` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `ownable`
--

CREATE TABLE `ownable` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(32) NOT NULL,
  `Model` int(11) NOT NULL,
  `Temp` int(11) NOT NULL DEFAULT -1,
  `Premium` int(11) NOT NULL DEFAULT 0,
  `Color_1` int(11) NOT NULL DEFAULT 0,
  `Color_2` int(11) NOT NULL DEFAULT 0,
  `Pos_X` float NOT NULL DEFAULT 2305,
  `Pos_Y` float NOT NULL DEFAULT -1827,
  `Pos_Z` float NOT NULL DEFAULT 22,
  `Pos_A` float NOT NULL DEFAULT 270,
  `Fuel` int(11) DEFAULT 50,
  `Cost` int(11) NOT NULL,
  `NoPark` int(11) NOT NULL DEFAULT 1,
  `Lock` int(11) NOT NULL DEFAULT 1,
  `Key` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `phonebook`
--

CREATE TABLE `phonebook` (
  `id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `name_add` varchar(32) NOT NULL,
  `day` int(11) NOT NULL,
  `mounth` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `data` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `promocodes`
--

CREATE TABLE `promocodes` (
  `id` int(11) NOT NULL,
  `owner` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `level` int(11) NOT NULL,
  `activations` int(11) NOT NULL,
  `donate` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `exp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `punishment`
--

CREATE TABLE `punishment` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `reason` varchar(144) NOT NULL,
  `type` int(11) NOT NULL,
  `admin` varchar(24) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `ucp_admin`
--

CREATE TABLE `ucp_admin` (
  `id` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `ucp_admin`
--

INSERT INTO `ucp_admin` (`id`, `Name`, `Password`) VALUES
(2, 'Looney', 'yutuber2EE1979079');

-- --------------------------------------------------------

--
-- Структура таблицы `ucp_news`
--

CREATE TABLE `ucp_news` (
  `n_id` int(11) NOT NULL,
  `n_data` varchar(50) NOT NULL,
  `n_images` text NOT NULL,
  `n_url` text NOT NULL,
  `n_title` text NOT NULL,
  `n_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ucp_news`
--

INSERT INTO `ucp_news` (`n_id`, `n_data`, `n_images`, `n_url`, `n_title`, `n_text`) VALUES
(48, '03.05.2024', 'https://sun6-23.userapi.com/impg/1JwiF1cP-R5Y1DDl1dpsPvmB5aaygL2idiZQwg/G2kVNzN1Zrs.jpg?size=1280x677&quality=95&sign=65d48bd8f229753bee87adf02e8f43e7&type=album', 'https://vk.com/orange_01?w=wall-194812152_681', 'Новый лаунчер', 'Рады сообщить, что наш новый лаунчер для игры на сервере уже доступен!\r\n\r\nТеперь вам не нужно будет устанавливать обновления вручную.\r\n(⚠ Старый лаунчер и сборку можно удалить)\r\n\r\nМы внедрили в лаунчер оптимизированную сборку, чтобы игра работала стабильно и без сбоев. Однако, если вы столкнетесь с какой-либо ошибкой, не стесняйтесь сообщить нам о ней, и мы постараемся её исправить!\r\n\r\nВ новом лаунчере доступны следующие функции:\r\n\r\n— Автоматическое обновление сборки\r\n— Проверка целостности файлов\r\n— Возможность изменения пути установки сборки');

-- --------------------------------------------------------

--
-- Структура таблицы `ucp_settings`
--

CREATE TABLE `ucp_settings` (
  `s_title` text NOT NULL,
  `s_favicon` text NOT NULL,
  `s_logo` text NOT NULL,
  `s_md5` int(11) NOT NULL DEFAULT 0,
  `s_genre` text NOT NULL,
  `s_vk` text NOT NULL,
  `s_vkteh` text NOT NULL,
  `s_ds` text NOT NULL,
  `s_yt` text NOT NULL,
  `s_tt` text NOT NULL,
  `s_tg` text NOT NULL,
  `s_forum` text NOT NULL,
  `s_launcher` text NOT NULL,
  `s_hts_video` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ucp_settings`
--

INSERT INTO `ucp_settings` (`s_title`, `s_favicon`, `s_logo`, `s_md5`, `s_genre`, `s_vk`, `s_vkteh`, `s_ds`, `s_yt`, `s_tt`, `s_tg`, `s_forum`, `s_launcher`, `s_hts_video`) VALUES
('ORANGE', '/assets/img/logos.png', '/assets/img/logos.png', 0, 'RP', 'https://vk.com/orange_01', 'https://vk.me/orange_01', 'https://discord.gg/ZnVNkUzWUs', 'https://www.youtube.com/channel/UCCe4JL7qFOtJu32jyMLIZMA', 'https://www.youtube.com/channel/UCCe4JL7qFOtJu32jyMLIZMA', 'https://vk.me/orange_01', 'https://forum.orange-rp.ru/', 'https://orange-rp.ru/game/Orange RolePlay.exe', 'https://vk.me/orange_01');

-- --------------------------------------------------------

--
-- Структура таблицы `vkmasters`
--

CREATE TABLE `vkmasters` (
  `id` int(11) NOT NULL,
  `idvk` int(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `vksend`
--

CREATE TABLE `vksend` (
  `id` int(11) NOT NULL,
  `cmd` varchar(30) NOT NULL DEFAULT 'nonecmd',
  `text` varchar(75) NOT NULL DEFAULT 'nonetext',
  `sender` varchar(32) NOT NULL DEFAULT 'nonesend',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 0,
  `reason` varchar(35) NOT NULL DEFAULT 'none',
  `amount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `vk_security`
--

CREATE TABLE `vk_security` (
  `u_name` varchar(24) NOT NULL,
  `u_userid` int(11) NOT NULL DEFAULT 0,
  `u_code` int(11) NOT NULL DEFAULT 0,
  `u_type` int(11) NOT NULL DEFAULT 0,
  `u_ip` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- Структура таблицы `warehouse`
--

CREATE TABLE `warehouse` (
  `id` int(1) NOT NULL DEFAULT 1,
  `rostov_metal` int(10) NOT NULL DEFAULT 0,
  `rostov_patr` int(10) NOT NULL DEFAULT 0,
  `rostov_narko` int(10) NOT NULL DEFAULT 0,
  `maykop_metal` int(10) NOT NULL DEFAULT 0,
  `maykop_patr` int(10) NOT NULL DEFAULT 0,
  `maykop_narko` int(10) NOT NULL DEFAULT 0,
  `odessa_metal` int(10) NOT NULL DEFAULT 0,
  `odessa_patr` int(10) NOT NULL DEFAULT 0,
  `odessa_narko` int(10) NOT NULL DEFAULT 0,
  `army_metal` int(10) NOT NULL DEFAULT 0,
  `army_patr` int(10) NOT NULL DEFAULT 0,
  `smi_money` int(10) NOT NULL DEFAULT 0,
  `rostov_storage` int(11) NOT NULL,
  `maykop_storage` int(11) NOT NULL,
  `odessa_storage` int(11) NOT NULL,
  `army_storage` int(11) NOT NULL,
  `moroz_kavkaz` int(11) NOT NULL DEFAULT 0,
  `moroz_gopota` int(11) NOT NULL DEFAULT 0,
  `moroz_skinhead` int(11) NOT NULL DEFAULT 0,
  `KaznaPraVo` int(10) NOT NULL,
  `metall` int(11) NOT NULL DEFAULT 100,
  `coal` int(11) NOT NULL DEFAULT 100,
  `armystorage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `warehouse`
--

INSERT INTO `warehouse` (`id`, `rostov_metal`, `rostov_patr`, `rostov_narko`, `maykop_metal`, `maykop_patr`, `maykop_narko`, `odessa_metal`, `odessa_patr`, `odessa_narko`, `army_metal`, `army_patr`, `smi_money`, `rostov_storage`, `maykop_storage`, `odessa_storage`, `army_storage`, `moroz_kavkaz`, `moroz_gopota`, `moroz_skinhead`, `KaznaPraVo`, `metall`, `coal`, `armystorage`) VALUES
(1, 570, 30502, 5753, 4719, 36609, 6164, 767, 36899, 50, 1500000, 1499610, 0, 1, 1, 1, 0, 0, 0, 0, 0, 111, 102, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `wbook`
--

CREATE TABLE `wbook` (
  `w_id` int(20) NOT NULL,
  `w_player` int(25) NOT NULL,
  `w_name` varchar(45) NOT NULL,
  `w_fraction` varchar(45) NOT NULL DEFAULT '-',
  `w_rank` int(3) NOT NULL,
  `w_reason` varchar(64) NOT NULL DEFAULT '',
  `w_mes` int(11) NOT NULL,
  `w_day` int(11) NOT NULL,
  `w_year` int(11) NOT NULL,
  `w_namerank` varchar(32) NOT NULL DEFAULT '-',
  `w_dal` varchar(32) NOT NULL DEFAULT '-',
  `w_reas` varchar(32) NOT NULL DEFAULT '-',
  `w_dalrank` varchar(32) NOT NULL DEFAULT '-'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `banlist`
--
ALTER TABLE `banlist`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `black_list`
--
ALTER TABLE `black_list`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `botvk`
--
ALTER TABLE `botvk`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `business_fin`
--
ALTER TABLE `business_fin`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `donate`
--
ALTER TABLE `donate`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `fractions_blacklist`
--
ALTER TABLE `fractions_blacklist`
  ADD PRIMARY KEY (`id_bl`);

--
-- Индексы таблицы `freekassa_payments`
--
ALTER TABLE `freekassa_payments`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gangzone`
--
ALTER TABLE `gangzone`
  ADD PRIMARY KEY (`gzid`);

--
-- Индексы таблицы `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `kvartiry`
--
ALTER TABLE `kvartiry`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `log_paymoney`
--
ALTER TABLE `log_paymoney`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `log_player`
--
ALTER TABLE `log_player`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `log_transfermoney`
--
ALTER TABLE `log_transfermoney`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ownable`
--
ALTER TABLE `ownable`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `phonebook`
--
ALTER TABLE `phonebook`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `promocodes`
--
ALTER TABLE `promocodes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `punishment`
--
ALTER TABLE `punishment`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ucp_admin`
--
ALTER TABLE `ucp_admin`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ucp_news`
--
ALTER TABLE `ucp_news`
  ADD PRIMARY KEY (`n_id`);

--
-- Индексы таблицы `vksend`
--
ALTER TABLE `vksend`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `vk_security`
--
ALTER TABLE `vk_security`
  ADD UNIQUE KEY `u_name` (`u_name`);

--
-- Индексы таблицы `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `wbook`
--
ALTER TABLE `wbook`
  ADD PRIMARY KEY (`w_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `banlist`
--
ALTER TABLE `banlist`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `black_list`
--
ALTER TABLE `black_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `botvk`
--
ALTER TABLE `botvk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `business`
--
ALTER TABLE `business`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `business_fin`
--
ALTER TABLE `business_fin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `donate`
--
ALTER TABLE `donate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `fractions_blacklist`
--
ALTER TABLE `fractions_blacklist`
  MODIFY `id_bl` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `freekassa_payments`
--
ALTER TABLE `freekassa_payments`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `gangzone`
--
ALTER TABLE `gangzone`
  MODIFY `gzid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT для таблицы `group`
--
ALTER TABLE `group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `kvartiry`
--
ALTER TABLE `kvartiry`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT для таблицы `log_paymoney`
--
ALTER TABLE `log_paymoney`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `log_player`
--
ALTER TABLE `log_player`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `log_transfermoney`
--
ALTER TABLE `log_transfermoney`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ownable`
--
ALTER TABLE `ownable`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `phonebook`
--
ALTER TABLE `phonebook`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `promocodes`
--
ALTER TABLE `promocodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `punishment`
--
ALTER TABLE `punishment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ucp_admin`
--
ALTER TABLE `ucp_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `ucp_news`
--
ALTER TABLE `ucp_news`
  MODIFY `n_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT для таблицы `vksend`
--
ALTER TABLE `vksend`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `wbook`
--
ALTER TABLE `wbook`
  MODIFY `w_id` int(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
