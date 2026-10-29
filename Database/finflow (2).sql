-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2026 at 07:19 AM
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
-- Table structure for table `budgets`
--

CREATE TABLE `budgets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_head_id` int(11) NOT NULL,
  `budget_month` varchar(100) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_at` timestamp NULL DEFAULT NULL,
  `Deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `budgets`
--

INSERT INTO `budgets` (`id`, `user_id`, `transaction_head_id`, `budget_month`, `amount`, `start_date`, `end_date`, `status`, `created_at`, `Updated_at`, `Deleted_at`) VALUES
(3, 1, 3, '2026-10-01', 45000.00, '0000-00-00', '0000-00-00', 1, '2026-10-18 07:03:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `budget_categories`
--

CREATE TABLE `budget_categories` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `budget_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `budget_amount` decimal(12,2) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `Deleted_at` datetime DEFAULT NULL,
  `Updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `challenges`
--

CREATE TABLE `challenges` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(150) DEFAULT NULL,
  `target_amount` decimal(12,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `Deleted_at` datetime DEFAULT NULL,
  `Updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `challenge_progress`
--

CREATE TABLE `challenge_progress` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `challenge_id` int(10) UNSIGNED NOT NULL,
  `current_amount` decimal(12,2) DEFAULT 0.00,
  `created_at` datetime DEFAULT current_timestamp(),
  `Deleted_at` datetime DEFAULT NULL,
  `Updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `goal_contributions`
--

CREATE TABLE `goal_contributions` (
  `id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `contribution_date` date DEFAULT NULL,
  `goal_earned_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `goal_contributions`
--

INSERT INTO `goal_contributions` (`id`, `goal_id`, `user_id`, `Name`, `amount`, `contribution_date`, `goal_earned_at`, `created_at`, `deleted_at`, `updated_at`) VALUES
(1, 1, 0, 'laptop', 22000.00, '2026-10-18', NULL, '2026-10-18 10:33:33', NULL, '2026-10-18 11:10:53');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `transaction_head_id` int(11) DEFAULT NULL,
  `loan_title` varchar(100) NOT NULL,
  `lender_name` varchar(150) NOT NULL,
  `loan_amount` decimal(12,2) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `interest_type` enum('reducing','flat') NOT NULL DEFAULT 'reducing',
  `tenure_months` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `emi_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `purpose` varchar(100) NOT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('active','completed') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `user_id`, `transaction_head_id`, `loan_title`, `lender_name`, `loan_amount`, `interest_rate`, `interest_type`, `tenure_months`, `start_date`, `end_date`, `emi_amount`, `purpose`, `notes`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 16, 'House Loan', 'Dutch Bangla Bank', 1500000.00, 9.12, 'flat', 12, '2026-10-25', '2027-10-25', 136400.00, 'Home', '', 'active', '2026-10-25 04:59:40', '2026-10-25 04:59:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recurring_expenses`
--

CREATE TABLE `recurring_expenses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(150) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `frequency` varchar(20) DEFAULT 'monthly',
  `next_due_date` date DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recurring_expenses`
--

INSERT INTO `recurring_expenses` (`id`, `user_id`, `category_id`, `title`, `amount`, `frequency`, `next_due_date`, `status`, `created_at`, `deleted_at`, `updated_at`) VALUES
(1, 0, 0, 'house rent', 26000.00, '2', '2026-11-17', 1, '2026-10-17 10:09:28', NULL, '2026-10-17 10:09:40');

-- --------------------------------------------------------

--
-- Table structure for table `savings_goals`
--

CREATE TABLE `savings_goals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal_name` varchar(100) NOT NULL,
  `target_amount` decimal(12,2) NOT NULL,
  `saved_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `target_date` date DEFAULT NULL,
  `transaction_head_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `savings_goals`
--

INSERT INTO `savings_goals` (`id`, `user_id`, `goal_name`, `target_amount`, `saved_amount`, `target_date`, `transaction_head_id`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 0, 'laptop budget', 50000.00, 0.00, '2026-10-30', 5, 1, '2026-10-18 06:29:36', NULL, NULL),
(4, 0, 'Desktop', 20000.00, 0.00, '2026-12-25', 12, 1, '2026-10-25 03:11:50', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `transaction_type` varchar(255) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_at` timestamp NULL DEFAULT NULL,
  `Deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_type`, `purpose`, `amount`, `user_id`, `transaction_date`, `created_at`, `Updated_at`, `Deleted_at`) VALUES
(1, 'income', 'Got Salary', 35000.00, 1, '2026-10-01', '2026-10-13 03:15:27', '2026-10-24 22:09:12', NULL),
(2, 'income', 'FDR', 500.00, 1, '2026-10-17', '2026-10-17 02:52:03', '2026-10-24 22:10:21', NULL),
(6, 'expense', 'Savings for laptop', 1000.00, 1, '2026-10-18', '2026-10-18 02:41:38', NULL, NULL),
(7, 'expense', 'Desktop', 1500.00, 1, '2026-10-19', '2026-10-18 02:55:51', '2026-10-24 22:12:27', NULL),
(8, 'expense', 'interest', 5000.00, 1, '2026-10-19', '2026-10-19 00:57:11', NULL, NULL),
(9, 'income', 'Savings for laptop', 11000.00, 1, '2026-10-19', '2026-10-19 01:00:40', '2026-10-24 22:08:14', NULL),
(10, 'income', 'Got lottery', 20000.00, 1, '2026-10-25', '2026-10-24 22:07:37', NULL, NULL),
(11, 'expense', 'House Loan', 4000.00, 1, '2026-10-25', '2026-10-24 23:29:47', '2026-10-25 00:15:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` int(11) NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `transaction_id` int(11) NOT NULL,
  `transaction_head` int(11) DEFAULT NULL,
  `dr` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cr` decimal(12,2) NOT NULL DEFAULT 0.00,
  `transaction_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_at` timestamp NULL DEFAULT NULL,
  `Deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `purpose`, `transaction_id`, `transaction_head`, `dr`, `cr`, `transaction_date`, `created_at`, `Updated_at`, `Deleted_at`) VALUES
(15, 'Savings for laptop', 6, 3, 0.00, 1000.00, '2026-10-18', '2026-10-18 02:41:38', NULL, NULL),
(16, '', 6, 5, 1000.00, 0.00, '2026-10-18', '2026-10-18 02:41:38', NULL, NULL),
(19, 'interest', 8, 3, 0.00, 5000.00, '2026-10-19', '2026-10-19 00:57:11', NULL, NULL),
(20, 'bank interest ', 8, 7, 5000.00, 0.00, '2026-10-19', '2026-10-19 00:57:11', NULL, NULL),
(26, 'Got lottery', 10, 3, 20000.00, 0.00, '2026-10-25', '2026-10-24 22:07:37', NULL, NULL),
(27, '', 10, 3, 0.00, 20000.00, '2026-10-25', '2026-10-24 22:07:37', NULL, NULL),
(28, 'Savings for laptop', 9, 3, 11000.00, 0.00, '2026-10-19', '2026-10-24 22:08:14', NULL, NULL),
(29, '', 9, 5, 0.00, 10000.00, '2026-10-19', '2026-10-24 22:08:14', NULL, NULL),
(30, '', 9, 5, 0.00, 1000.00, '2026-10-19', '2026-10-24 22:08:14', NULL, NULL),
(31, 'Got Salary', 1, 3, 35000.00, 0.00, '2026-10-01', '2026-10-24 22:09:12', NULL, NULL),
(32, 'Got Cash Salary', 1, 1, 0.00, 32000.00, '2026-10-01', '2026-10-24 22:09:12', NULL, NULL),
(33, 'Got Cash Salary', 1, 1, 0.00, 3000.00, '2026-10-01', '2026-10-24 22:09:12', NULL, NULL),
(34, 'FDR', 2, 4, 500.00, 0.00, '2026-10-17', '2026-10-24 22:10:21', NULL, NULL),
(35, '', 2, 4, 0.00, 500.00, '2026-10-17', '2026-10-24 22:10:21', NULL, NULL),
(36, 'Desktop', 7, 3, 0.00, 1500.00, '2026-10-19', '2026-10-24 22:12:27', NULL, NULL),
(37, '', 7, 12, 500.00, 0.00, '2026-10-19', '2026-10-24 22:12:27', NULL, NULL),
(38, '', 7, 12, 1000.00, 0.00, '2026-10-19', '2026-10-24 22:12:27', NULL, NULL),
(47, 'House Loan', 11, 3, 0.00, 4000.00, '2026-10-25', '2026-10-25 00:15:55', NULL, NULL),
(48, '', 11, 16, 4000.00, 0.00, '2026-10-25', '2026-10-25 00:15:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_head`
--

CREATE TABLE `transaction_head` (
  `id` int(11) NOT NULL,
  `head_type` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `head_name` varchar(100) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_head`
--

INSERT INTO `transaction_head` (`id`, `head_type`, `user_id`, `head_name`, `parent_id`, `status`, `created_at`, `deleted_at`, `updated_at`) VALUES
(1, 3, 0, 'income', 0, 1, '2026-10-13 09:35:19', NULL, '2026-10-13 09:35:19'),
(3, 2, 0, 'Cash', 1, 1, '2026-10-13 12:28:09', NULL, NULL),
(4, 2, 0, 'Bank Interest', 1, 1, '2026-10-13 12:28:23', NULL, NULL),
(5, 5, 1, 'laptop budget', 3, 1, '2026-10-18 12:29:36', NULL, NULL),
(6, 5, 0, 'Fridge budget', 3, 1, '2026-10-19 09:09:04', NULL, NULL),
(7, 6, 0, 'Loan', 3, 1, '2026-10-19 09:10:31', NULL, NULL),
(8, 4, 0, 'Grocery', 3, 1, '2026-10-19 09:12:29', NULL, NULL),
(9, 4, 0, 'House Rent', 3, 1, '2026-10-19 09:13:16', NULL, NULL),
(10, 3, 0, 'House Rent', 3, 1, '2026-10-19 09:13:33', NULL, NULL),
(12, 5, 1, 'Desktop', NULL, 1, '2026-10-25 09:11:50', NULL, NULL),
(16, 6, 1, 'House Loan', 7, 1, '2026-10-25 10:59:40', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `contact_no`, `email`, `password`, `status`, `remember_token`, `image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Fyroz Anika Tapti', '', 'rozanika96@gmail.com', '2ac14875a25aafbfc6b6e705bbc7e798a44fc816', 1, NULL, NULL, '2026-10-11 03:53:01', '2026-10-11 03:53:01', NULL),
(2, 'Fyroz Anika Tapti', '', 'rozanika97@gmail.com', '2ac14875a25aafbfc6b6e705bbc7e798a44fc816', 1, NULL, NULL, '2026-10-11 03:53:43', '2026-10-11 03:53:43', NULL),
(3, 'Fyroz Anika Tapti', '', 'rozanika98@gmail.com', '2ac14875a25aafbfc6b6e705bbc7e798a44fc816', 1, NULL, NULL, '2026-10-11 03:54:29', '2026-10-11 03:54:29', NULL),
(4, 'Fyroz Anika Tapti', '', 'fyroz@gmail.com', 'c14f14fa9524ea8890f2f6fa4f57fa90233480b3', 1, '27981791691111874529', NULL, '2026-10-11 03:57:07', '2026-10-11 03:58:31', NULL),
(5, 'Fyroz', '', 'fyroz12@gmail.com', 'ace9b0804dcfd45f8ac0445596ff41f65dc3c9b0', 1, '27701792897570193423', NULL, '2026-10-11 05:57:29', '2026-10-25 03:06:10', NULL),
(6, 'Fyroz Anika Tapti', '', 'fyroz789@gmail.com', 'eafebf6f38d4d0a44fac1993536bf9e1463e532d', 1, '22631791698475657052', NULL, '2026-10-11 06:00:56', '2026-10-11 06:01:15', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `budgets`
--
ALTER TABLE `budgets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `budget_categories`
--
ALTER TABLE `budget_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challenges`
--
ALTER TABLE `challenges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challenge_progress`
--
ALTER TABLE `challenge_progress`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `goal_contributions`
--
ALTER TABLE `goal_contributions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recurring_expenses`
--
ALTER TABLE `recurring_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_goals`
--
ALTER TABLE `savings_goals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_head`
--
ALTER TABLE `transaction_head`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `budgets`
--
ALTER TABLE `budgets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `budget_categories`
--
ALTER TABLE `budget_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `challenges`
--
ALTER TABLE `challenges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `challenge_progress`
--
ALTER TABLE `challenge_progress`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `goal_contributions`
--
ALTER TABLE `goal_contributions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `recurring_expenses`
--
ALTER TABLE `recurring_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `savings_goals`
--
ALTER TABLE `savings_goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `transaction_head`
--
ALTER TABLE `transaction_head`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
