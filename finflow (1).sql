-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 07, 2026 at 07:54 PM
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
-- Database: `finflow`
--

-- --------------------------------------------------------

--
-- Table structure for table `cost_income_head`
--

CREATE TABLE `cost_income_head` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `head_name` varchar(100) NOT NULL,
  `Parent_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `Deleted_at` datetime DEFAULT current_timestamp(),
  `Updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cost_income_head`
--

INSERT INTO `cost_income_head` (`id`, `user_id`, `head_name`, `Parent_id`, `status`, `created_at`, `Deleted_at`, `Updated_at`) VALUES
(1, 1, 'Food', 0, 1, '2026-10-07 23:20:43', '2026-10-07 23:20:43', '2026-10-07 23:20:43'),
(2, 1, 'Salary', 0, 1, '2026-10-07 23:20:43', '2026-10-07 23:20:43', '2026-10-07 23:20:43');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `Cost_income_head_id` int(11) NOT NULL,
  `Dr` decimal(12,2) DEFAULT NULL,
  `Cr` decimal(12,2) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `Deleted_at` datetime DEFAULT current_timestamp(),
  `Updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `Cost_income_head_id`, `Dr`, `Cr`, `transaction_date`, `created_at`, `Deleted_at`, `Updated_at`) VALUES
(6, 1, 1, 600.00, 100.00, '2026-10-07', '2026-10-07 23:22:35', NULL, '2026-10-07 23:22:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `Deleted_at` datetime DEFAULT current_timestamp(),
  `Updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `status`, `created_at`, `Deleted_at`, `Updated_at`) VALUES
(1, 'Anika', 'anika@gmail.com', '123456', '01700000000', 1, '2026-10-07 23:16:31', '2026-10-07 23:16:31', '2026-10-07 23:16:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cost_income_head`
--
ALTER TABLE `cost_income_head`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `Parent_id` (`Parent_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `Cost_income_head_id` (`Cost_income_head_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cost_income_head`
--
ALTER TABLE `cost_income_head`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cost_income_head`
--
ALTER TABLE `cost_income_head`
  ADD CONSTRAINT `cost_income_head_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cost_income_head_ibfk_2` FOREIGN KEY (`Parent_id`) REFERENCES `cost_income_head` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`Cost_income_head_id`) REFERENCES `cost_income_head` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
