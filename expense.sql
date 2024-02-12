-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 12, 2024 at 04:54 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expense`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_expense_sp` (IN `_id` INT, IN `_amount` FLOAT(11,2), IN `_type` VARCHAR(50) CHARSET utf8, IN `_description` TEXT CHARSET utf8, IN `_userId` VARCHAR(50) CHARSET utf8)   BEGIN

if(_type='Expense')THEN

if((SELECT get_student_balance_fn(_userId)< _amount))THEN
SELECT 'Deny' as Message;

ELSE
INSERT INTO expense (expense.amount,expense.type,expense.description,expense.user_id)
VALUES(_amount,_type,_description,_userId);

SELECT 'Registred'AS Message;

END IF;
ELSE
INSERT INTO expense (expense.amount,expense.type,expense.description,expense.user_id)
VALUES(_amount,_type,_description,_userId);
SELECT 'Registred'AS Message;

END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_student_balance_fn` (`_userId` VARCHAR(50) CHARSET utf8) RETURNS FLOAT(11,2)  BEGIN

set @balance = 0.00;

set @income= (SELECT SUM(expense.amount) FROM expense 
 WHERE expense.type= 'Income' AND expense.user_id= _userId);

set @expense= (SELECT SUM(expense.amount) FROM expense 
 WHERE expense.type= 'Expense' AND expense.user_id= _userId);
 
 set @balance = (ifnull(@income, 0.00)-
 ifnull(@expense, 0.00));
 
 RETURN @balance;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(11) NOT NULL,
  `amount` float(11,2) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `amount`, `type`, `description`, `user_id`, `date`) VALUES
(4, 10.00, 'Income', 'from ajax', 'ca202', '2024-02-02 13:54:20'),
(6, 200.00, 'Income', 'Mushaar', 'ca202', '2024-02-02 13:57:59'),
(7, 10.00, 'Income', 'fasiix', 'ca202', '2024-02-02 14:03:34'),
(8, 10.00, 'Income', 'fasiix', 'ca202', '2024-02-02 14:44:41'),
(9, 10.00, 'Income', 'Mushaar', 'ca202', '2024-02-02 16:09:17'),
(10, 12.00, 'Income', 'fasiix', 'ca202', '2024-02-02 16:16:55'),
(11, 10.00, 'Income', 'from ajax', 'ca202', '2024-02-02 16:17:16'),
(12, 12.00, 'Income', 'from ajax', 'ca202', '2024-02-02 16:18:20'),
(13, 123.00, 'Income', 'qoslo', 'ca202', '2024-02-02 16:22:31'),
(14, 123.00, 'Income', 'qoslo', 'ca202', '2024-02-02 16:22:31'),
(15, 123.00, 'Income', 'qoslo', 'ca202', '2024-02-02 16:22:31'),
(16, 123.00, 'Income', 'qoslo', 'ca202', '2024-02-02 16:22:31'),
(17, 10.00, 'Income', 'from ajax', 'ca202', '2024-02-02 16:23:31'),
(18, 2.00, 'Income', 'JJJ', 'ca202', '2024-02-02 16:25:29'),
(19, 12.00, 'Income', 'fasiix', 'ca202', '2024-02-02 16:29:29'),
(20, 10.00, 'Income', 'fasiix', 'ca202', '2024-02-03 05:04:23'),
(21, 12.00, 'Income', 'from ajax', 'ca202', '2024-02-03 06:07:03'),
(22, 600.00, '', 'host', 'USR001', '2024-02-03 06:49:42'),
(23, 600.00, '', 'mur', 'USR001', '2024-02-03 06:49:50'),
(24, 12.00, 'Income', 'keen', 'ca202', '2024-02-03 07:02:44'),
(25, 10.00, 'Expense', 'tababar gal', 'ca202', '2024-02-03 07:06:42'),
(26, 90.00, 'Income', 'jacayl wade', 'c11414', '2024-02-04 06:54:40'),
(27, 400.00, 'Expense', 'rent', 'ca202', '2024-02-04 07:23:23'),
(28, 40.00, 'Expense', 'rent', 'ca202', '2024-02-04 07:23:28'),
(29, 60.00, 'Expense', 'rent', 'ca202', '2024-02-04 07:23:37'),
(30, 12.00, 'Income', 'keen', 'ca202', '2024-02-04 07:24:09'),
(31, 10.00, 'Income', 'tababar gal', 'ca202', '2024-02-04 07:27:20'),
(32, 10.00, 'Income', 'way inoo taalaa ', 'ca202', '2024-02-04 07:27:44'),
(33, 9000.00, 'Income', 'keen', 'ca202', '2024-02-04 07:28:29'),
(34, 9000.00, 'Expense', 'keen', 'ca202', '2024-02-04 07:28:36'),
(35, 9000.00, 'Income', 'keen', 'ca202', '2024-02-04 07:28:43'),
(36, 12.00, 'Income', 'tababar gal', 'ca202', '2024-02-04 07:30:14'),
(37, 12.00, 'Income', 'keen', 'ca202', '2024-02-04 07:31:24'),
(38, 12.00, 'Expense', 'keen', 'ca202', '2024-02-04 07:31:31'),
(39, 30.00, 'Income', 'aabe i siiyay', 'ca202', '2024-02-04 07:32:11'),
(40, 2.00, 'Income', 'aabe i siiyay', 'ca202', '2024-02-04 07:33:23'),
(41, 9400.00, 'Expense', 'wada bixi', 'ca202', '2024-02-04 07:35:00'),
(42, 10.00, 'Income', 'from aja', 'USR001', '2024-02-04 07:45:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
