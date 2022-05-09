SET FOREIGN_KEY_CHECKS=0;

-- inserting values in dim_tags

INSERT INTO Stack_overflow_OLAP.dim_tags
(select id, tagname from Stack_Overflow_Data.tags_csv);

-- inserting values in dim_language

INSERT INTO Stack_overflow_OLAP.dim_language(language,annual_salary)
(select a.language, a.average_annual_salary 
FROM Stack_Overflow_Data.languages_csv as a,
Stack_overflow_OLAP.dim_tags as t
where lower(a.language) = lower(t.TagName)
);

-- inserting values in dim_badges
INSERT INTO Stack_overflow_OLAP.dim_badges
(select id, userid, name, date from Stack_Overflow_Data.badges_csv);

-- inserting values in dim_users 
INSERT INTO Stack_overflow_OLAP.dim_users
(select a.id, a.reputation, a.displayname,
a.creationdate, a.lastaccessdate, a.websiteurl,
a.location, a.aboutme, a.age, a.profileimageurl, a.views from Stack_Overflow_Data.users_csv as a
left join Stack_overflow_OLAP.dim_badges as b
on a.reputation = b.BadgeId 
);

-- inserting values in fact_posts

INSERT INTO Stack_overflow_OLAP.fact_posts
(select p.id, p.owneruserid, p.viewcount, p.answercount, 
p.commentcount, p.favoritecount, p.tags, p.body from Stack_Overflow_Data.posts_csv as p
left join Stack_overflow_OLAP.dim_users as u
on p.owneruserid = u.UserId
left join Stack_overflow_OLAP.dim_tags as t
on t.TagName = p.tags
where p.id is not Null);

-- inserting values in dim_comments 

INSERT INTO Stack_overflow_OLAP.dim_comments 
(SELECT c.id, c.postid,  c.score, c.text, c.creationdate FROM Stack_Overflow_Data.comments_csv as c
left join Stack_overflow_OLAP.fact_posts as p
on p.PostId = c.postid
);

-- inserting values in dim_votes

INSERT INTO Stack_overflow_OLAP.dim_votes
(SELECT c.id, p.postid, c.votetypeid, c.creationdate FROM Stack_Overflow_Data.votes_csv as c
left join Stack_overflow_OLAP.fact_posts as p
on p.PostId = c.postid);





