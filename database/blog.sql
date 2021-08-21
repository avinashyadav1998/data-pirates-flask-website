-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 21, 2021 at 07:47 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `sno` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `phone_num` varchar(12) NOT NULL,
  `msg` varchar(120) NOT NULL,
  `date` date NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'avi', '54543534', 'vffdffb ', '2021-04-06', 'ccd@gmail.com'),
(2, 'Ravi', '999999912', 'Hello World', '2021-04-06', 'dfd@gmail.com'),
(3, 'raju', '324324', 'I am newbi', '2021-04-06', 'raj@gmail.com'),
(4, 'Jagdev', '8920762823', 'I love this journal ', '2021-04-06', 'jd@hotmail.com'),
(5, 'Ajay', '854894895', 'I am really excited to discuss some ML topic with you :) ', '2021-04-06', 'aju@gmail.com'),
(6, 'Narendra ', '8920762345', 'You Don’t Learn to Walk by Following Rules. You Learn by Doing, and by Falling Over :) :)\r\n\r\nHappy Learning ', '2021-04-07', 'naren@gmail.com'),
(7, 'SOnam', '6489564', 'It\'s good !!!', '2021-04-07', 'sonam@gmail.com'),
(8, 'fgfg', '54543', 'fgdfgdf', '2021-04-07', 'gfgf'),
(9, 'ffdg', '676476', 'ghgfhghfg', '2021-04-07', 'ghgf'),
(10, 'ffdg', '676476', 'ghgfhghfg', '2021-04-07', 'ghgf'),
(11, 'SriRam', '8920762345', 'WOW ! !', '2021-08-21', 'sriram123@gmail.com'),
(12, 'SRIRAM Kumar', '9876543210', 'It is a great oppourituty to learn.', '2021-08-21', 'sri111@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `journal`
--

CREATE TABLE `journal` (
  `sno` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `slug` varchar(21) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL,
  `img_file` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `journal`
--

INSERT INTO `journal` (`sno`, `title`, `slug`, `content`, `date`, `img_file`) VALUES
(1, 'coding is life', 'first_post', 'Becoming a computer programmer would be great because there are many options in this career by having the ability to produce an operating system, or a game for the world. Computer programmers have many opportunities in life to find a job they would love. Programmers can work independently, or in a big company. Programmers have and are creating the future for computers.\r\n\r\nComputer programmers have a wide range on what they can do. Computer programmers write the detailed list of instructions the computer will follow in the software (Great Sample Resume). This is also called “coding.” Programmers test their software, or other peoples, to see if it works properly (Career Cruising). Programmers study the tasks that the program will…show more content…\r\nThe programmer will either have to go to the business or the home in some sort of transportation, or by using his own computer. If the programmer is working on certain software for his clients, then he may have built it in a way to assist them from his computer.', '2021-04-07 01:07:06', 'post-bg.jpg'),
(2, 'Importance of data and data collection', 'second_post', 'Data is an any concept of a matter or incident. âDatumâ is a Greek word. Itâs plural from is âDataâ. This means to give or something given. Data comes from observations made upon reality. A data is a collection of statical information of values of the variable of interest in a study.\r\nSource of Data\r\nData can be defined as the quantitative or qualitative values of a variable. Data is thought to be the lowest unit of information from which other measurements and analysis can be done. Data can be numbers, images, words, figures, facts or ideas. Data in itself cannot be understood and to get information from the data one must interpret it into meaningful information. There are various methods of interpreting data. Data sources are broadly classified into primary and secondary data.', '2021-04-06 00:00:00', 'post2-bg.jpg'),
(4, 'Sql', 'Sql', 'SQL', '2021-04-07 01:07:40', 'na'),
(5, 'Python', 'fourth_post', 'Python is very addictive.\r\nFor you know about it, more you  fall in love with it', '2021-04-07 15:10:43', 'post1-bg.jpg'),
(6, 'Algo', 'fifth_post', 'Algo is \"AATMA\" of coding', '2021-04-06 00:00:00', 'na'),
(8, 'Data', 'first_post', 'Becoming a computer******!!! programmer would be great because there are many options in this career by having the ability to produce an operating system, or a game for the world. Computer programmers have many opportunities in life to find a job they would love. Programmers can work independently, or in a big company. Programmers have and are creating the future for computers.\r\n\r\nComputer programmers have a wide range on what they can do. Computer programmers write the detailed list of instructions the computer will follow in the software (Great Sample Resume). This is also called “coding.” Programmers test their software, or other peoples, to see if it works properly (Career Cruising). Programmers study the tasks that the program will…show more content…\r\nThe programmer will either have to go to the business or the home in some sort of transportation, or by using his own computer. If the programmer is working on certain software for his clients, then he may have built it in a way to assist them from his computer.', '2021-04-07 01:15:27', 'post-bg.jpg'),
(11, 'BI', 'bi_post', 'Power BI', '2021-04-07 01:08:45', 'hah'),
(12, 'Oracle', 'oracle_post', 'Oracle is fortune 500 MNC', '2021-04-07 01:12:46', 'na'),
(14, 'ML', 'ml_post', 'ML bole to Machine Learning !', '2021-04-07 14:04:03', 'fun-bg.png'),
(15, 'Power BI Updates', 'biupdates_post', 'April POwer BI Update is about to come !!', '2021-04-07 15:09:33', 'home-bg.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--
-- Error reading structure for table blog.posts: #1932 - Table 'blog.posts' doesn't exist in engine
-- Error reading data for table blog.posts: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `blog`.`posts`' at line 1

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `journal`
--
ALTER TABLE `journal`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `journal`
--
ALTER TABLE `journal`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
