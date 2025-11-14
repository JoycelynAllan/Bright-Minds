-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2025 at 12:25 AM
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
-- Database: `bm2025`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `achievementID` int(11) NOT NULL,
  `childID` int(11) NOT NULL,
  `type` text NOT NULL,
  `name` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `child`
--

CREATE TABLE `child` (
  `childID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `displayName` varchar(1000) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `child`
--

INSERT INTO `child` (`childID`, `userID`, `displayName`, `age`) VALUES
(1, 2, 'Ella', 8),
(2, 3, 'Sam', 9);

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `gameID` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`gameID`, `title`, `description`) VALUES
(1, 'Memory Match Game', 'Flip cards to find pairs that match! Test your memory and focus!'),
(2, 'Catch the Star', 'Use your arrow keys to catch as many falling stars as you can before time runs out!');

-- --------------------------------------------------------

--
-- Table structure for table `play_sessions`
--

CREATE TABLE `play_sessions` (
  `playSessionsID` int(11) NOT NULL,
  `childID` int(11) NOT NULL,
  `gameID` int(11) NOT NULL,
  `quizID` int(11) NOT NULL,
  `storyID` int(11) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_time` datetime NOT NULL,
  `score` double NOT NULL,
  `xp_earned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `quizID` int(11) NOT NULL,
  `question` text NOT NULL,
  `correctAnswer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quizID`, `question`, `correctAnswer`) VALUES
(1, 'What color is the sky on a sunny day?', 'Blue'),
(2, 'How many legs does a spider have?', '8'),
(3, 'Which animal is known as the King of the Jungle?', 'Lion'),
(4, 'What do bees make?', 'Honey');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_options`
--

CREATE TABLE `quiz_options` (
  `quiz_optionsID` int(11) NOT NULL,
  `quizID` int(11) NOT NULL,
  `optionText` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `quiz_options`
--

INSERT INTO `quiz_options` (`quiz_optionsID`, `quizID`, `optionText`) VALUES
(1, 1, 'Blue'),
(2, 1, 'Green'),
(3, 1, 'Red'),
(4, 1, 'Yellow'),
(5, 2, '6'),
(6, 2, '8'),
(7, 2, '10'),
(8, 2, '4'),
(9, 3, 'Elephant'),
(10, 3, 'Tiger'),
(11, 3, 'Lion'),
(12, 3, 'Giraffe'),
(13, 4, 'Honey'),
(14, 4, 'Milk'),
(15, 4, 'Butter'),
(16, 4, 'Cheese');

-- --------------------------------------------------------

--
-- Table structure for table `story`
--

CREATE TABLE `story` (
  `storyID` int(11) NOT NULL,
  `title` text NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `story`
--

INSERT INTO `story` (`storyID`, `title`, `text`) VALUES
(1, 'The Brave Little Elephant', 'Once upon a time, in the heart of the jungle, there was a little elephant named Ella who dreamed of flying...'),
(2, 'The Rainbow Painter', 'A little boy named Sam loved colors so much...');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `username` varchar(1000) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `email` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `username`, `password`, `email`) VALUES
(1, 'parent123', 'hashedpassword1', 'parent@gmail,com'),
(2, 'ella_kid', 'hashedpassword2', 'ella@gmail.com'),
(3, 'sam_kid', 'hashedpassword3', 'sam@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`achievementID`);

--
-- Indexes for table `child`
--
ALTER TABLE `child`
  ADD PRIMARY KEY (`childID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`gameID`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quizID`);

--
-- Indexes for table `quiz_options`
--
ALTER TABLE `quiz_options`
  ADD PRIMARY KEY (`quiz_optionsID`),
  ADD KEY `quizID` (`quizID`);

--
-- Indexes for table `story`
--
ALTER TABLE `story`
  ADD PRIMARY KEY (`storyID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `child`
--
ALTER TABLE `child`
  ADD CONSTRAINT `child_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quiz_options`
--
ALTER TABLE `quiz_options`
  ADD CONSTRAINT `quiz_options_ibfk_1` FOREIGN KEY (`quizID`) REFERENCES `quiz` (`quizID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
