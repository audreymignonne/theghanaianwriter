CREATE TABLE `users`(
    `user_id` tinyint(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_pass` varchar(150) NOT NULL,
  `user_country` varchar(30) NOT NULL,
  `user_city` varchar(30) NOT NULL,
  `career` varchar(30) NOT NULL,
  `resume` varchar(500) NOT NULL,
  `user_contact` varchar(15) NOT NULL,
  `user_image` varchar(100) DEFAULT NULL,
  `user_role` int(11) NOT NULL
  );

CREATE TABLE `employer`(
    `emp_id` tinyint(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `company` varchar(50) NOT NULL,
  `rep_first_name` varchar(50) NOT NULL,
  `rep_last_name` varchar(50) NOT NULL,
  `position` varchar(30) NOT NULL,
  `emp_email` varchar(50) NOT NULL,
  `emp_pass` varchar(150) NOT NULL,
  `emp_country` varchar(30) NOT NULL,
  `emp_city` varchar(30) NOT NULL,
  `website` varchar(50) NOT NULL,
  `emp_contact` varchar(15) NOT NULL,
  `emp_image` varchar(100) DEFAULT NULL,
  `emp_role` int(11) NOT NULL
);

CREATE TABLE `opportunities`(
    `opp_id` tinyint(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `emp_id` tinyint(11) NOT NULL,
    `title` varchar(50) NOT NULL,
    `company` varchar(50) NOT NULL,
    `country` varchar(30) NOT NULL,
    `city` varchar(30) NOT NULL,
    `category` varchar(50) NOT NULL,
    `desc` varchar(500) NOT NULL,
    `pay` varchar(50) NOT NULL,
    `deadline` date NOT NULL,
    `date_posted` date NOT NULL
);

CREATE TABLE `applications`(
    `app_id` tinyint(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `opp_id` tinyint(11) NOT NULL,
    `user_id` tinyint(11) NOT NULL,
    `emp_id` tinyint(11) NOT NULL,
    `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `user_country` varchar(30) NOT NULL,
  `user_city` varchar(30) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `resume` varchar(500) NOT NULL,
  `cover_letter` varchar(500) NOT NULL,
  `portfolio_link` varchar(2083) NOT NULL
);


CREATE TABLE `applied`(
    `user_id` tinyint(11) NOT NULL,
    `app_id` tinyint(11) NOT NULL,
    `status` varchar(10) NOT NULL 
);

CREATE TABLE `messages`(
`message_id` tinyint(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`user_id_from` tinyint(11) NOT NULL,
`user_id_to` tinyint(11) NOT NULL,
`content` varchar(300) NOT NULL,
`date_created` date NOT NULL,
`time` time NOT NULL
);

CREATE TABLE `posts`(
   `post_id` tinyint(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
   `user_id` tinyint(11) NOT NULL,
   `date` date NOT NULL,
   `content` varchar(300) NOT NULL,
   `photo` varchar(255) DEFAULT NULL,
   `video` varchar(255) DEFAULT NULL
);

CREATE TABLE `shares`(
  `post_id` tinyint(11) NOT NULL,
  `shared_user_id` tinyint(11) NOT NULL
);

CREATE TABLE `likes`(
  `post_id` tinyint(11) NOT NULL,
  `liked_user_id` tinyint(11) NOT NULL
);

CREATE TABLE `comments`(
  `comment_id` tinyint(11) NOT NULL,
  `post_id` tinyint(11) NOT NULL,
  `commented_user_id` tinyint(11) NOT NULL,
  `comment_date` date,
  `content` varchar(50)
);



-- indexes

ALTER TABLE `users`
    ADD UNIQUE KEY `user_email` (`user_email`);

ALTER TABLE `employer`
    ADD UNIQUE KEY `emp_email` (`emp_email`);

ALTER TABLE `opportunities`
    ADD KEY `emp_id` (`emp_id`);

ALTER TABLE `applications`
    ADD KEY `opp_id` (`opp_id`), 
    ADD KEY `user_id` (`user_id`), 
    ADD KEY `emp_id` (`emp_id`);

ALTER TABLE `applied`
    ADD KEY `user_id` (`user_id`),
    ADD KEY `app_id` (`app_id`);

ALTER TABLE `messages`
    ADD KEY `user_id_from` (`user_id_from`),
    ADD KEY `user_id_to` (`user_id_to`); 

ALTER TABLE `posts`
    ADD KEY `user_id` (`user_id`);

ALTER TABLE `shares`
    ADD KEY `post_id` (`post_id`),
    ADD KEY `shared_user_id` (`shared_user_id`);

ALTER TABLE `likes`
    ADD KEY `post_id` (`post_id`),
    ADD KEY `liked_user_id` (`liked_user_id`);

ALTER TABLE `comments`
    ADD KEY `commented_user_id` (`commented_user_id`),
    ADD KEY `post_id` (`post_id`);



-- Constraints for dumped tables

ALTER TABLE `opportunities`
  ADD CONSTRAINT `opportunities_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employer` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employer` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`opp_id`) REFERENCES `opportunities` (`opp_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `applications_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `applied`
  ADD CONSTRAINT `applied_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `applied_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `applications` (`app_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_id_from`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`user_id_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `shares`
  ADD CONSTRAINT `shares_ibfk_1` FOREIGN KEY (`shared_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`liked_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`commented_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE;




