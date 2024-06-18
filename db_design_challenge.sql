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
  first_name varchar(25),
  last_name varchar(50),
  email varchar(50),
  password varchar(255),
  date_joined date,
  bio text
);

-- New Blog table
CREATE TABLE blog_post (
  blog_id bigserial PRIMARY KEY,
  author_id bigint,
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
