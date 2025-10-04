SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `_fitness`
--

-- --------------------------------------------------------

--
-- Table structure for table `body`
--

CREATE TABLE `body` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `measurement_type` varchar(64) NOT NULL,
  `instruction` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `body`
--

INSERT INTO `body` (`id`, `name`, `measurement_type`, `instruction`) VALUES
(1, 'Chest', 'Circumference', 'Measure around the widest part of your chest, or bust for women, usually just above the nipples.'),
(2, 'Waist', 'Circumference', 'Find the narrowest part of your torso, often around the belly button.'),
(3, 'Hips', 'Circumference', 'Measure the widest point of your hips or glutes.'),
(4, 'Glutes', 'Circumference', 'Measure at the widest part of your thigh, often the midpoint between the lower glute and the back of the knee.'),
(5, 'Calves', 'Circumference', 'Measure the widest part of your calf, located at the halfway point between your knee and ankle.'),
(6, 'Biceps', 'Circumference', 'Measure the bicep at the halfway point between the shoulder and the elbow, with your arm relaxed at your side.'),
(7, 'Forearms', 'Circumference', ''),
(8, 'Body Mass', 'Weight', ''),
(9, 'Body Fat Mass', 'Weight', ''),
(10, 'Body Fat %', 'Percentage', ''),
(11, 'FFM', 'Weight', ''),
(12, 'Muscle Mass', 'Weight', ''),
(13, 'TBW Mass', 'Weight', ''),
(14, 'TBW %', 'Percentage', ''),
(15, 'Bone Mass', 'Weight', ''),
(16, 'Height', 'Height', '');

-- --------------------------------------------------------

--
-- Table structure for table `diary`
--

CREATE TABLE `diary` (
  `id` int(11) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `diary` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `effort`
--

CREATE TABLE `effort` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exercise`
--

CREATE TABLE `exercise` (
  `id` int(11) NOT NULL,
  `muscle_group` int(11) NOT NULL,
  `exercise` varchar(128) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `video` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `exercise`
--

INSERT INTO `exercise` (`id`, `muscle_group`, `exercise`, `description`, `video`) VALUES
(1, 1, 'Smith machine hip thrust', NULL, NULL),
(2, 1, 'Smith machine hip thrust', NULL, NULL),
(3, 1, 'Barbell hip thrust', NULL, NULL),
(4, 1, 'Dumbbell romanian deadlift', NULL, NULL),
(5, 1, 'Barbell romanian deadlift', NULL, NULL),
(6, 1, 'Dumbbell goblet squat', NULL, NULL),
(7, 1, 'Kettlebell goblet squat', NULL, NULL),
(8, 2, 'Cable seated row (High)', NULL, NULL),
(9, 2, 'Cable seated row (Mid)', NULL, NULL),
(10, 2, 'Cable seated row (Low)', NULL, NULL),
(11, 2, 'Bent-over barbell row', NULL, NULL),
(12, 2, 'Pull-ups', NULL, NULL),
(13, 2, 'Muscle-ups', NULL, NULL),
(14, 2, 'Cable pull-down', NULL, NULL),
(15, 2, 'Cable pull-up', NULL, NULL),
(16, 2, 'Partial deadlift', NULL, NULL),
(17, 3, 'Push-ups', NULL, NULL),
(18, 3, 'Dips', NULL, NULL),
(19, 3, 'Barbell bench press (Flat)', NULL, NULL),
(20, 3, 'Barbell bench press (Incline)', NULL, NULL),
(21, 3, 'Smith machine bench press (Flat)', NULL, NULL),
(22, 3, 'Smith machine bench press (Incline)', NULL, NULL),
(23, 3, 'Dumbbell bench press (Flat)', NULL, NULL),
(24, 3, 'Dumbbell bench press (Incline)', NULL, NULL),
(25, 3, 'Cable fly (Chest)', NULL, NULL),
(26, 3, 'Cable fly (Front deltoid)', NULL, NULL),
(27, 3, 'Cable fly (Rear deltoid)', NULL, NULL),
(28, 3, 'Dumbbell fly (Flat)', NULL, NULL),
(29, 4, 'Dumbbell shoulder press', NULL, NULL),
(30, 4, 'Dumbbell lateral raise', NULL, NULL),
(31, 4, 'Dumbbell lateral raise (full rom)', NULL, NULL),
(32, 5, 'Box squat', NULL, NULL),
(33, 5, 'Barbell back squat', NULL, NULL),
(34, 5, 'Smith machine back squat', NULL, NULL),
(35, 5, 'Barbell front squat', NULL, NULL),
(36, 5, 'Smith machine front squat', NULL, NULL),
(37, 5, 'Hack squat', NULL, NULL),
(38, 5, 'Bulgarian squat', NULL, NULL),
(39, 5, 'Leg press', NULL, NULL),
(40, 6, 'Deadlift', NULL, NULL),
(41, 6, 'Ham-raise', NULL, NULL),
(42, 6, 'Leg curl', NULL, NULL),
(43, 7, 'Calf raise', NULL, NULL),
(44, 8, 'Reverse-grip barbell bench press', NULL, NULL),
(45, 8, 'Dumbbell overhead tricep extension', NULL, NULL),
(46, 8, 'Cable overhead tricep extension', NULL, NULL),
(47, 8, 'Skull crusher', NULL, NULL),
(48, 9, 'Barbell curl', NULL, NULL),
(49, 9, 'EZ bar curl', NULL, NULL),
(50, 9, 'Dumbbell curl (easy)', NULL, NULL),
(51, 9, 'Dumbbell curl (strict)', NULL, NULL),
(52, 9, 'Dumbbell curl (hammer)', NULL, NULL),
(53, 9, 'Preacher curl', NULL, NULL),
(54, 10, 'Plank', NULL, NULL),
(55, 10, 'Russian twist', NULL, NULL),
(56, 10, 'Pallof press', NULL, NULL),
(57, 10, 'Cable crunch', NULL, NULL),
(58, 11, 'Wrist curl', NULL, NULL),
(59, 11, 'Farmers walk', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `location` point DEFAULT NULL,
  `exercise` int(11) NOT NULL,
  `weight` float DEFAULT NULL,
  `tension_level` int(11) DEFAULT NULL,
  `reps` int(11) DEFAULT NULL,
  `sets` int(11) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `effort` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `measurements`
--

CREATE TABLE `measurements` (
  `id` int(11) NOT NULL,
  `datetime` timestamp NULL DEFAULT current_timestamp(),
  `body_part` int(11) NOT NULL,
  `measurement` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `muscle_groups`
--

CREATE TABLE `muscle_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `muscle_groups`
--

INSERT INTO `muscle_groups` (`id`, `name`) VALUES
(1, 'Glutes'),
(2, 'Back'),
(3, 'Chest'),
(4, 'Shoulders'),
(5, 'Quadriceps'),
(6, 'Hamstrings'),
(7, 'Calves'),
(8, 'Triceps'),
(9, 'Biceps'),
(10, 'Abs'),
(11, 'Grip and Forearms');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `body`
--
ALTER TABLE `body`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `diary`
--
ALTER TABLE `diary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `effort`
--
ALTER TABLE `effort`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exercise`
--
ALTER TABLE `exercise`
  ADD PRIMARY KEY (`id`),
  ADD KEY `muscle_group` (`muscle_group`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exercise` (`exercise`);

--
-- Indexes for table `measurements`
--
ALTER TABLE `measurements`
  ADD KEY `body_part` (`body_part`);

--
-- Indexes for table `muscle_groups`
--
ALTER TABLE `muscle_groups`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `body`
--
ALTER TABLE `body`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `diary`
--
ALTER TABLE `diary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `effort`
--
ALTER TABLE `effort`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exercise`
--
ALTER TABLE `exercise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `muscle_groups`
--
ALTER TABLE `muscle_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exercise`
--
ALTER TABLE `exercise`
  ADD CONSTRAINT `exercise_ibfk_1` FOREIGN KEY (`muscle_group`) REFERENCES `muscle_groups` (`id`);

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `log_ibfk_1` FOREIGN KEY (`exercise`) REFERENCES `exercise` (`id`);

--
-- Constraints for table `measurements`
--
ALTER TABLE `measurements`
  ADD CONSTRAINT `measurements_ibfk_1` FOREIGN KEY (`body_part`) REFERENCES `body` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
