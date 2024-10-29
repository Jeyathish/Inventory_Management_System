-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Oct 29, 2024 at 12:33 PM
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
-- Database: `inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE `billing` (
  `invoice_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `customer_name` varchar(100) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `payment_status` enum('Paid','Pending') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`invoice_id`, `date`, `customer_name`, `total_amount`, `payment_status`) VALUES
(1, '2024-10-29 11:10:24', 'Jeyathish', 600.00, 'Paid'),
(2, '2024-10-29 11:30:58', 'Sumitran', 150000.00, 'Paid');

-- --------------------------------------------------------

--
-- Table structure for table `billing_items`
--

CREATE TABLE `billing_items` (
  `item_id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity_sold` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billing_items`
--

INSERT INTO `billing_items` (`item_id`, `invoice_id`, `product_id`, `quantity_sold`, `price`) VALUES
(7, 1, 1, 2, 300.00),
(8, 2, 2, 3, 50000.00);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `customer_name` varchar(255) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_status` enum('Pending','Paid') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `p_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `quantity` int(100) NOT NULL,
  `price` int(255) NOT NULL,
  `description` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`p_id`, `name`, `category`, `quantity`, `price`, `description`) VALUES
(1, 'Wireless Mouse', 'Electronics', 175, 300, 'A wireless mouse with a 2.4 GHz USB receiver and 12-month battery life.'),
(2, 'Laptop', 'Electronics', 95, 50000, '15.6-inch laptop with Intel i7 processor, 16GB RAM, and 512GB SSD.'),
(3, 'Smartphone', 'Electronics', 9, 100, 'Noise-canceling over-ear headphones with Bluetooth 5.0 and built-in microphone.'),
(4, 'Desk Chair', 'Office Supplies', 5, 500, 'A comfortable ergonomic office chair with adjustable height and lumbar support.'),
(5, 'LED Monitor', 'Accessories', 3, 10000, 'Energy-efficient LED desk lamp with adjustable brightness.'),
(6, 'Bluetooth Speaker', 'Audio Devices', 5, 2000, 'Portable Bluetooth speaker with 100-hour battery life and water-resistant design.'),
(7, 'Gaming Keyboard', 'Computer Peripherals', 9, 850, 'Mechanical keyboard with customizable RGB lighting and programmable keys.'),
(8, 'Electric Kettle', 'Kitchen Appliances', 0, 6000, '1.7-liter electric kettle with auto shut-off and boil-dry protection.'),
(9, 'Standing Desk', 'Office Supplies', 18, 2500, 'Adjustable standing desk with motorized height adjustment and memory settings.'),
(10, 'Smartwatch', 'Wearables', 8, 1000, 'Smartwatch with fitness tracking, heart rate monitor, and GPS capabilities.'),
(11, 'Computer', 'Electronics', 2, 60000, '15.6-inch screen with Intel i7 processor, 16GB RAM, and 512GB SSD.'),
(12, 'LED Light', 'Electronics', 4, 200, 'It is a white light used for night.'),
(13, 'Wireless Headphone', 'Audio Devices', 6, 1500, 'Noise-canceling over-ear headphones with Bluetooth 5.0 and built-in microphone.'),
(14, 'Table Fan', 'Electronics', 20, 3500, 'It is a table fan which can be adjustable'),
(15, 'Ceiling Fan', 'Electronics', 5, 5000, 'It was fixed in the ceiling wall with long wings.'),
(16, 'Tooth Paste', 'Refreshment ', 30, 50, 'It will make your teeth very clean as white as snow.'),
(17, 'Tooth Brush', 'Refreshment ', 6, 50, 'It was a strong brush which was not to be broken.\r\n'),
(18, 'Pencil', 'Stationery products', 50, 20, 'It made up of strong wood and long lasting.'),
(19, 'Pen', 'Stationery products', 3, 40, 'It is made up of strong medal and long lasting ink was used.'),
(20, 'Ink Pen', 'Stationery products', 6, 100, 'It is made up of strong medal and long lasting ink was used.');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `s_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`s_id`, `name`, `phone`, `email`) VALUES
(1, 'Jeyathish', '9342030292', 'jeyathish0987@gmail.com'),
(2, 'Mari', '7654758444', 'mari@gmail.com'),
(3, 'Sumitran', '8563646333', 'sumi@gmail.com'),
(4, 'Faizan', '5037535455', 'faizan@gmail.com'),
(5, 'Shreeba', '9673545344', 'shree@gmail.com'),
(6, 'Sabeer', '9574554645', 'sab@gmail.com'),
(7, 'Priya', '9774557355', 'priya@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `billing_items`
--
ALTER TABLE `billing_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`s_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing`
--
ALTER TABLE `billing`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `billing_items`
--
ALTER TABLE `billing_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `billing_items`
--
ALTER TABLE `billing_items`
  ADD CONSTRAINT `billing_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `billing` (`invoice_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `billing_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`p_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
