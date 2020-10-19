-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2020 at 02:32 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flask`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` int(12) NOT NULL,
  `message` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `phone`, `message`) VALUES
(1, 'rahul', 'rahul@flippercode.com', 123654789, 'This is rahul bhatt'),
(2, 'divyang', 'divyang@gmail.com', 123654, 'this is my first message'),
(3, 'Pradakshina Goswami', 'goswamipradakshina@gmail.com', 2147483647, 'This is my testing message for the python working.'),
(4, 'Sakshi', 'sakshi@gmail.com', 123654789, 'This is sakshi, How can I connect you'),
(5, 'bikaner', 'bikaner@gmail.com', 987452525, 'This is Bikaner'),
(6, 'divyang', 'tst', 0, ''),
(7, 'Bikaner', 'bikaner@gmail.com', 986547552, 'This is bikaner'),
(8, 'Pune Maharashtra', 'pune@gmail.com', 659874123, 'This is pune location'),
(11, 'Flippercode Private Limited', 'goswamidivyang@gmail.com', 2147483647, 'I want to discuss about the Python Programming. Please contact me so we can discuss on this.\r\n'),
(12, 'Flippercode Private Limited', 'support@flipper.com', 985621471, 'I want to discuss about the python programming. Contact me as soon as possible.'),
(13, 'Flippercode Private Limited', 'support@flipper.com', 985621471, 'I want to discuss about the python programming. Contact me as soon as possible.'),
(14, 'Divyang', 'abc@yahoo.com', 23654789, 'This is the testing page'),
(15, 'Sakshi', 'sakshi@yahoo.co.in', 98562317, 'This is sakshi for the testing'),
(16, 'Divyang Goswami', 'divtechnosys@gmail.com', 986574123, 'I have a new project for you. '),
(17, 'sakshi', 'sakshi@gmail.com', 123654, 'This is sakshi');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `serial` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`serial`, `title`, `slug`, `content`, `date`) VALUES
(100, 'What is flask and how to integrate with the machine learning', 'what-is-flask', 'This is the flask and there is no need to make it.', '2020-10-13'),
(101, 'Components of Flask', 'component-on-flask', 'The microframework Flask is based on the Pocoo projects, Werkzeug and Jinja22.\r\n\r\nWerkzeug\r\nWerkzeug is a utility library for the Python programming language, in other words a toolkit for Web Server Gateway Interface (WSGI) applications, and is licensed under a BSD License. Werkzeug can realize software objects for request, response, and utility functions. It can be used to build a custom software framework on top of it and supports Python 2.7 and 3.5 and later.[14][15]\r\n\r\nJinja\r\nMain article: Jinja (template engine)\r\nJinja, also by Ronacher, is a template engine for the Python programming language and is licensed under a BSD License. Similar to the Django web framework, it handles templates in a sandbox.', '2020-10-12'),
(102, 'Learning with Flask', 'learning-with-flask', 'Flask is a micro web framework written in Python. It is classified as a microframework because it does not require particular tools or libraries.[3] It has no database abstraction layer, form validation, or any other components where pre-existing third-party libraries provide common functions. However, Flask supports extensions that can add application features as if they were implemented in Flask itself. Extensions exist for object-relational mappers, form validation, upload handling, various open authentication technologies and several common framework related tools.', '2020-10-13'),
(103, 'Documentation and examples for opt-in styling of tables (given their prevalent use in JavaScript plugins) with Bootstrap.', 'Documentation using Bootstrap', 'Due to the widespread use of tables across third-party widgets like calendars and date pickers, we’ve designed our tables to be opt-in. Just add the base class .table to any <table>, then extend with custom styles or our various included modifier classes.\r\n\r\nUsing the most basic table markup, here’s how .table-based tables look in Bootstrap. All table styles are inherited in Bootstrap 4, meaning any nested tables will be styled in the same manner as the parent.', '2020-10-14'),
(104, 'Dot net vs PHP', 'dot-net-php', 'This is the new post that compares between the botnet and PHP programming language.', '2020-10-19'),
(106, 'How to create a new location', 'create-new-location', 'In this tutorial you will learn about the create location.\r\n\r\nDivyang Goswami', '2020-10-19'),
(107, 'Buddy Press Member', 'buddy-press-member', 'With this BuddyPress extension, you can display simple to complex BuddyPress social networks on google maps beautifully. All the member’s information displayed in info-window and listing are dynamic and can be managed with the help of placeholders from the back-end.\r\n\r\nNow display your BuddyPress member’s network on google maps beautifully, the way you wanted it to be. This google maps extension has all the flexibility you can think of implementing.', '2020-10-19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`serial`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `serial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
