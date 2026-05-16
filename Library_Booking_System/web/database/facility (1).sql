-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: May 16, 2026 at 01:19 PM
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
-- Database: `librarydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `facility`
--

CREATE TABLE `facility` (
  `facility_id` int(11) NOT NULL,
  `facility_name` varchar(100) NOT NULL,
  `unit_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'AVAILABLE',
  `image_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `facility`
--

INSERT INTO `facility` (`facility_id`, `facility_name`, `unit_name`, `description`, `capacity`, `status`, `image_url`) VALUES
(1, 'Study Room', 'Study Room A', 'Quiet individual study room', 1, 'AVAILABLE', 'study.jpg'),
(2, 'Study Room', 'Study Room B', 'Quiet individual study room', 1, 'AVAILABLE', 'study.jpg'),
(3, 'Study Room', 'Study Room C', 'Quiet individual study room', 1, 'AVAILABLE', 'study.jpg'),
(4, 'Study Room', 'Study Room D', 'Quiet individual study room', 1, 'AVAILABLE', 'study.jpg'),
(5, 'Study Room', 'Study Room E', 'Quiet individual study room', 1, 'AVAILABLE', 'study.jpg'),
(6, 'Group Discussion Room', 'Room 1', 'Collaborative room', 8, 'AVAILABLE', 'discussion.jpg'),
(7, 'Group Discussion Room', 'Room 2', 'Collaborative room', 8, 'AVAILABLE', 'discussion.jpg'),
(8, 'Group Discussion Room', 'Room 3', 'Collaborative room', 8, 'AVAILABLE', 'discussion.jpg'),
(9, 'Group Discussion Room', 'Room 4', 'Collaborative room', 8, 'AVAILABLE', 'discussion.jpg'),
(10, 'Group Discussion Room', 'Room 5', 'Collaborative room', 8, 'AVAILABLE', 'discussion.jpg'),
(11, 'Computer Lab', 'Computer Lab A', 'High performance computers', 30, 'AVAILABLE', 'lab.jpg'),
(12, 'Computer Lab', 'Computer Lab B', 'High performance computers', 30, 'AVAILABLE', 'lab.jpg'),
(13, 'Seminar Hall', 'Auditorium A', 'Large hall for events', 100, 'AVAILABLE', 'hall.jpg'),
(14, 'Seminar Hall', 'Auditorium B', 'Large hall for events', 100, 'AVAILABLE', 'hall.jpg'),
(15, 'Media Room', 'Media Space', 'Recording studio', 8, 'AVAILABLE', 'media.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `facility`
--
ALTER TABLE `facility`
  ADD PRIMARY KEY (`facility_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `facility`
--
ALTER TABLE `facility`
  MODIFY `facility_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
