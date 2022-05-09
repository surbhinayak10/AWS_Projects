DROP DATABASE IF EXISTS Stack_overflow_OLAP;

CREATE DATABASE Stack_overflow_OLAP;

USE Stack_overflow_OLAP;

CREATE TABLE `dim_comments` (
  `comment_Id` int PRIMARY KEY ,
  `Score` int,
  `Text` longtext,
  `CreationDate` datetime
);

CREATE TABLE `dim_tags` (
  `tag_id` int,
  `TagName` varchar(500) PRIMARY KEY
);

CREATE TABLE `dim_language` (
  `language_id` int PRIMARY KEY auto_increment,
  `language` varchar(255),
  `annual_salary` bigint(20)
);

CREATE TABLE `fact_posts` (
  `PostId` int primary key,
  `comment_Id` int,
  `OwnerUserId` double,
  `ViewCount` int,
  `AnswerCount` int,
  `CommentCount` int,
  `FavoriteCount` int,
  `Tags` varchar(500),
  `Body` varchar(50000)
);

CREATE TABLE `dim_users` (
  `UserId` double primary key,
  `BadgeId` int,
  `DisplayName` varchar(2000),
   `creationdate` varchar(2000),
  `LastAccessDate` varchar(2000),
  `WebsiteUrl` varchar(2000),
  `Location` varchar(2000),
  `AboutMe` varchar(2000),
  `Age` int,
  `ProfileImageUrl` varchar(2000),
  views bigint(20)
);

CREATE TABLE `dim_badges` (
  `BadgeId` int PRIMARY KEY ,
  `UserId` int,
  `Name` varchar(255),
  `Date` datetime
);

ALTER TABLE `fact_posts` ADD FOREIGN KEY (`comment_Id`) REFERENCES `dim_comments` (`comment_Id`);

ALTER TABLE `fact_posts` ADD FOREIGN KEY (`Vote_Id`) REFERENCES `dim_votes` (`id`);

ALTER TABLE `fact_posts` ADD FOREIGN KEY (`Tags`) REFERENCES `dim_tags` (`TagName`);

ALTER TABLE `fact_posts` ADD FOREIGN KEY (`OwnerUserId`) REFERENCES `dim_users` (`UserId`);

ALTER TABLE `dim_users` ADD FOREIGN KEY (`BadgeId`) REFERENCES `dim_badges` (`BadgeId`);

ALTER TABLE `dim_language` ADD FOREIGN KEY (`language`) REFERENCES `dim_tags` (`TagName`);
