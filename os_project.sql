-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2024 at 07:33 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `os project`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `Ctgr_Code` int(3) NOT NULL,
  `Ctgr_Title` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `food items`
--

CREATE TABLE `food items` (
  `Category_Code` int(3) NOT NULL,
  `Food_Code` bigint(7) NOT NULL,
  `Food Name` varchar(25) NOT NULL,
  `Price` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `included in`
--

CREATE TABLE `included in` (
  `Order_Code` int(3) NOT NULL,
  `Food_Code` bigint(7) NOT NULL,
  `Amounts` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `Order_Code` bigint(10) NOT NULL,
  `Customer Name` varchar(25) NOT NULL,
  `Bill` bigint(10) NOT NULL,
  `Time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`Ctgr_Code`);

--
-- Indexes for table `food items`
--
ALTER TABLE `food items`
  ADD PRIMARY KEY (`Food_Code`),
  ADD KEY `Category` (`Category_Code`);

--
-- Indexes for table `included in`
--
ALTER TABLE `included in`
  ADD KEY `Food` (`Food_Code`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`Order_Code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `Ctgr_Code` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `food items`
--
ALTER TABLE `food items`
  MODIFY `Food_Code` bigint(7) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `Order_Code` bigint(10) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `food items`
--
ALTER TABLE `food items`
  ADD CONSTRAINT `Category` FOREIGN KEY (`Category_Code`) REFERENCES `category` (`Ctgr_Code`);

--
-- Constraints for table `included in`
--
ALTER TABLE `included in`
  ADD CONSTRAINT `Food` FOREIGN KEY (`Food_Code`) REFERENCES `food items` (`Food_Code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
