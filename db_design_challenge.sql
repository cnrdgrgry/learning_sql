/*
TechNative Database Design challenge

Task 1

We have been asked to design a database for a new website - a blog for a well known company. Let's call them The Guardian 2.

We need to design the table(s) for this blog.

Here are some requirements:

    The database needs to store information on blog posts
    Each blog post can have a single author
    Each author can write multiple blog posts
    Each blog post should have a title, summary, the full blog post, and the date    it was written
    We should also store each author's name, email address, password, a short bio    , and the date that they joined

Here are some tasks:

    Design the table(s), and which fields they should have
    Specify the data types for each field
    Specify any constraints (e.g. primary keys, foreign keys, unique constraints)
    Write the SQL to create these table(s)
    Write the SQL to insert some fake blog data
    There should be at least five authors
    Each author should have written between 1-5 blog posts
*/

-- New DATABASE
CREATE DATABASE guardian_2;

-- New author table
CREATE TABLE authors (
  id bigserial PRIMARY KEY,
  first_name varchar(25) NOT NULL,
  last_name varchar(50) NOT NULL, 
  email varchar(50) NOT NULL UNIQUE,
  password varchar(255) NOT NULL,
  date_joined date NOT NULL DEFAULT CURRENT_DATE,
  bio text
);

-- New Blog table
CREATE TABLE blog_post (
  blog_id bigserial PRIMARY KEY,
  author_id int,
  title varchar(100),
  summary varchar(255),
  blog_content text,
  date date,
  FOREIGN KEY (author_id) REFERENCES authors(id)
);


--insert (AI generated) fake content into the new tables.

INSERT INTO authors (first_name, last_name, email, password, date_joined, bio) VALUES
('Alex', 'Johnson', 'alex.johnson@email.com', 'ajpassword123', '2022-06-17', 'Alex has been a passionate writer for over a decade, focusing on technology and innovation.'),
('Samantha', 'Doe', 'samantha.doe@email.com', 'sdpassword321', '2022-06-18', 'Samantha is an acclaimed author in the realms of fantasy fiction and has published several bestsellers.'),
('Michael', 'Smith', 'michael.smith@email.com', 'mspassword123', '2022-06-19', 'Michael is a freelance journalist with a keen interest in environmental issues and sustainability.'),
('Jessica', 'Brown', 'jessica.brown@email.com', 'jbpassword321', '2022-06-20', 'Jessica specializes in historical literature and has received numerous awards for her work.'),
('Daniel', 'Lee', 'daniel.lee@email.com', 'dlpassword123', '2022-06-21', 'Daniel is a novelist and screenwriter known for his compelling character-driven stories.');


INSERT INTO blog_post (author_id, title, summary, blog_content, date) VALUES
(1, 'The Future of Tech', 'Exploring upcoming technological innovations.', 'In this article, Alex Johnson delves into the most anticipated technological advancements on the horizon...', '2022-06-17'),
(1, 'Innovative Minds', 'Interviews with leading figures in technology.', 'Alex Johnson brings insights from interviews with pioneers in the tech industry...', '2022-06-17');

INSERT INTO blog_post (author_id, title, summary, blog_content, date) VALUES
(2, 'Fantasy Worlds', 'Creating immersive fantasy universes.', 'Samantha Doe shares her process for crafting vivid and enchanting worlds in her fiction...', '2022-06-18'),
(2, 'Bestseller Secrets', 'What makes a fantasy novel successful.', 'Join Samantha Doe as she breaks down the elements that make a fantasy story resonate with readers...', '2022-06-18');

INSERT INTO blog_post (author_id, title, summary, blog_content, date) VALUES
(3, 'Green Journalism', 'The role of media in environmental advocacy.', 'Michael Smith discusses how journalism can influence environmental policy and public perception...', '2022-06-19'),
(3, 'Sustainable Living', 'Practical tips for eco-friendly lifestyles.', 'In this piece, Michael Smith provides actionable advice for reducing your carbon footprint...', '2022-06-19');

INSERT INTO blog_post (author_id, title, summary, blog_content, date) VALUES
(4, 'Historical Narratives', 'The power of storytelling in history.', 'Jessica Brown examines how historical narratives shape our understanding of the past...', '2022-06-20'),
(4, 'Award-Winning History', 'A look at Jessica Brown''s acclaimed works.', 'This article reviews the historical literature that has earned Jessica Brown her awards...', '2022-06-20');

INSERT INTO blog_post (author_id, title, summary, blog_content, date) VALUES
(5, 'Character Creation', 'Crafting compelling protagonists and antagonists.', 'Daniel Lee discusses his approach to creating memorable characters in his novels...', '2022-06-21'),
(5, 'Screenwriting Tips', 'From novel to screenplay: adapting stories for the screen.', 'Join Daniel Lee as he shares insights on adapting written work for film and television...', '2022-06-21');

-- List all blog post titles
-- checking:
TABLE blog_post;
-- doing;
SELECT title
FROM blog_post;

-- List all blog titles with author's last_name
-- checking;
TABLE authors;
TABLE blog_post;
-- doing;
SELECT authors.first_name, authors.last_name, blog_post.title
FROM authors JOIN blog_post
ON authors.id = blog_post.author_id;

-- List all authors
SELECT first_name, last_name
FROM authors;

-- List all authors, alphabetically
SELECT first_name, last_name
FROM authors
ORDER BY last_name;

-- List all authors and count how many blog post's they've created.
SELECT authors.first_name, authors.last_name, COUNT(blog_post.author_id)
FROM authors JOIN blog_post
ON authors.id = blog_post.author_id
GROUP BY authors.first_name, authors.last_name
ORDER BY authors.last_name;

-- List all blog posts for a specific author
SELECT authors.first_name, authors.last_name, blog_post.title
FROM authors JOIN blog_post
ON authors.id = blog_post.author_id
WHERE authors.last_name = 'Doe';

-- List all blog posts, sorted by the oldest first
SELECT authors.first_name, authors.last_name, blog_post.title, blog_post.date
FROM authors JOIN blog_post
ON authors.id = blog_post.author_id
ORDER BY blog_post.date ASC;

/*

TASK 2
The company has decided that they would like to add tags to blog posts.

Here are some requirements:

    Each blog post can have one or more tags
    Each tag can be applied to one or more blog posts
*/

-- Create a tags table

CREATE TABLE blog_tags (
  tag_id serial PRIMARY KEY,
  tag_content varchar(30) NOT NULL UNIQUE
);

-- Create a table that's needed to connect tags to blogposts (many to many!).

CREATE TABLE blog_intersect_tags (
  blog_id int NOT NULL,
  tag_id int NOT NULL,
  PRIMARY KEY (blog_id, tag_id),
  FOREIGN KEY (blog_id) REFERENCES blog_post(blog_id),
  FOREIGN KEY (tag_id) REFERENCES blog_tags(tag_id)
);


-- Insert (AI generated) Tags
INSERT INTO blog_tags (tag_content) VALUES
('Technology'),
('Innovation'),
('Interviews'),
('Fantasy'),
('World-Building'),
('Bestsellers'),
('Environment'),
('Sustainability'),
('Green Living'),
('History'),
('Storytelling'),
('Awards'),
('Characters'),
('Screenwriting'),
('Adaptation');

-- Insert Blog Intersect Tags
-- (AI Gen) Tags for Alex Johnson's posts
INSERT INTO blog_intersect_tags (blog_id, tag_id) VALUES
(1, 1), -- The Future of Tech | Technology
(1, 2), -- The Future of Tech | Innovation
(2, 3), -- Innovative Minds | Interviews

-- (AI Gen) Tags for Samantha Doe's posts
(3, 4), -- Fantasy Worlds | Fantasy
(3, 5), -- Fantasy Worlds | World-Building
(4, 4), -- Bestseller Secrets | Fantasy
(4, 6), -- Bestseller Secrets | Bestsellers

-- (AI Gen) Tags for Michael Smith's posts
(5, 7), -- Green Journalism | Environment
(5, 8), -- Green Journalism | Sustainability
(6, 8), -- Sustainable Living | Sustainability
(6, 9), -- Sustainable Living | Green Living

-- (AI Gen) Tags for Jessica Brown's posts
(7, 10), -- Historical Narratives | History
(7, 11), -- Historical Narratives | Storytelling
(8, 12), -- Award-Winning History | Awards

-- (AI Gen) Tags for Daniel Lee's posts
(9, 13), -- Character Creation | Characters
(10, 14), -- Screenwriting Tips | Screenwriting
(10, 15); -- Screenwriting Tips | Adaptation

-- Retrieve a list of all tags
TABLE blog_tags;
-- or the proper way!
SELECT *
FROM blog_tags;

-- Retrieve a list of all tags and how many times they've been used.

SELECT blog_tags.tag_content, COUNT(blog_intersect_tags.blog_id)
FROM blog_tags
-- Left join to account for the fact that not all tags may be associated with
-- a post.
LEFT JOIN blog_intersect_tags
ON blog_tags.tag_id = blog_intersect_tags.tag_id
GROUP BY blog_tags.tag_content;

--Retrieve a list of tags for a particular blog post
--    seems to require double JOIN which I had to research and play with to
--    get right.

SELECT blog_post.title, blog_post.summary, blog_tags.tag_content
FROM blog_tags
JOIN blog_intersect_tags ON blog_tags.tag_id = blog_intersect_tags.tag_id
JOIN blog_post ON blog_intersect_tags.blog_id = blog_post.blog_id
WHERE blog_post.blog_id = 3;
