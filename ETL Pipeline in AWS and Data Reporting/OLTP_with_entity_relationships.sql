CREATE TABLE `comments` (
  `Id` int PRIMARY KEY AUTO_INCREMENT,
  `PostId` int,
  `Score` int,
  `Text` longtext,
  `CreationDate` datetime,
  `UserId` int,
  `UserDisplayName` varchar(255)
);

CREATE TABLE `tags` (
  `Id` int PRIMARY KEY AUTO_INCREMENT,
  `TagNmae` varchar(255),
  `Count` int,
  `ExcerptPostId` int,
  `WikiPostId` int
);

CREATE TABLE `postLinks` (
  `Id` int AUTO_INCREMENT,
  `CreationDate` datetime,
  `PostId` int,
  `RelatedPostId` int,
  `LinkTypeId` int,
  PRIMARY KEY (`Id`, `CreationDate`)
);

CREATE TABLE `postHistory` (
  `Id` int PRIMARY KEY AUTO_INCREMENT,
  `PostHistoryTypeId` int,
  `PostId` int,
  `RevisionGUID` varchar(255),
  `CreationDate` datetime,
  `UserId` int,
  `Text` longtext,
  `Comment` Text,
  `UserDisplayName` varchar(255)
);

CREATE TABLE `votes` (
  `Id` int PRIMARY KEY AUTO_INCREMENT,
  `PostId` int,
  `VoteTypeId` int,
  `CreationDate` date,
  `UserId` int,
  `BountyAmount` int
);

CREATE TABLE `badges` (
  `Id` int PRIMARY KEY AUTO_INCREMENT,
  `UserId` int,
  `Name` varchar(255),
  `Date` datetime
);

CREATE TABLE `posts` (
  `Id` int AUTO_INCREMENT,
  `PostTypeId` int,
  `AcceptedAnswerId` int,
  `CreationDate` datetime,
  `Score` int,
  `ViewCount` int,
  `Body` longtext,
  `OwnerUserId` int,
  `LastActivityDate` datetime,
  `Title` varchar(255),
  `Tags` varchar(255),
  `AnswerCount` int,
  `CommentCount` int,
  `FavoriteCount` int,
  `LastEditorUserId` int,
  `LastEditDate` datetime,
  `CommunityOwnedDate` datetime,
  `ParentId` int,
  `ClosedDate` datetime,
  `OwnerDisplayName` varchar(255),
  `LastEditorDisplayName` varchar(255),
  PRIMARY KEY (`Id`, `CreationDate`)
);

CREATE TABLE `users` (
  `Id` int PRIMARY KEY AUTO_INCREMENT,
  `Reputation` int,
  `CreationDate` datetime,
  `DisplayName` varchar(255),
  `LastAccessDate` datetime,
  `WebsiteUrl` varchar(255),
  `Location` varchar(255),
  `AboutMe` longtext,
  `Views` int,
  `UpVotes` int,
  `Downvotes` int,
  `AccountId` int,
  `Age` int,
  `ProfileImageUrl` varchar(255)
);

ALTER TABLE `posts` ADD FOREIGN KEY (`Id`) REFERENCES `comments` (`Id`);

ALTER TABLE `users` ADD FOREIGN KEY (`Id`) REFERENCES `comments` (`Id`);

ALTER TABLE `posts` ADD FOREIGN KEY (`Id`) REFERENCES `tags` (`Id`);

ALTER TABLE `posts` ADD FOREIGN KEY (`Id`) REFERENCES `postLinks` (`Id`);

ALTER TABLE `posts` ADD FOREIGN KEY (`CreationDate`) REFERENCES `postLinks` (`CreationDate`);

ALTER TABLE `posts` ADD FOREIGN KEY (`Id`) REFERENCES `postHistory` (`Id`);

ALTER TABLE `users` ADD FOREIGN KEY (`Id`) REFERENCES `postHistory` (`Id`);

ALTER TABLE `posts` ADD FOREIGN KEY (`Id`) REFERENCES `votes` (`Id`);

ALTER TABLE `users` ADD FOREIGN KEY (`Id`) REFERENCES `votes` (`Id`);

ALTER TABLE `users` ADD FOREIGN KEY (`Id`) REFERENCES `badges` (`Id`);

ALTER TABLE `users` ADD FOREIGN KEY (`Id`) REFERENCES `posts` (`Id`);

ALTER TABLE `users` ADD FOREIGN KEY (`CreationDate`) REFERENCES `posts` (`CreationDate`);

