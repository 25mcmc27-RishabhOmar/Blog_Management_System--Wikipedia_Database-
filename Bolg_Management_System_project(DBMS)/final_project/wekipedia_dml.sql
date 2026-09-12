USE wekipedia;

-- insert user 
INSERT INTO user (user_name, password, email)
VALUES
('Aman', 'pass1', 'aman@example.com'),
('Riya', 'pass2', 'riya@example.com'),
('Karan', 'pass3', 'karan@example.com'),
('Sneha', 'pass4', 'sneha@example.com'),
('Vikram', 'pass5', 'vikram@example.com'),
('Neha', 'pass6', 'neha@example.com'),
('Aditi', 'pass7', 'aditi@example.com'),
('Suresh', 'pass8', 'suresh@example.com'),
('Komal', 'pass9', 'komal@example.com'),
('Admin', 'admin123', 'admin@example.com');

select * from user;

-- insert page
INSERT INTO page (user_id, page_title, page_type, page_namespace)
VALUES
(1, 'Computer Science', 'article', 0),
(2, 'Physics', 'article', 0),
(3, 'Mathematics', 'article', 0),
(4, 'Biology', 'article', 0),
(5, 'Chemistry', 'article', 0),
(6, 'Geography', 'article', 0),
(7, 'History', 'article', 0),
(8, 'Economics', 'article', 0),
(9, 'Programming', 'article', 0),
(10, 'India', 'article', 0);

-- insert page restriction data
INSERT INTO page_restrictions (page_id, type_restrict, level, reason)
VALUES
(1, 'edit', 'sysop', 'High traffic page'),
(2, 'move', 'autoconfirmed', 'Prevent spam');

-- block 
INSERT INTO block (admin_id, user_id, reason)
VALUES
(1,1,'Spamming'),
(1,3,'Fake edits');

-- text
INSERT INTO text (old_text)
VALUES
('Intro to Computer Science'),
('Basics of Physics'),
('Math fundamentals'),
('Biology overview'),
('Chemistry introduction'),
('Geography details'),
('History timeline'),
('Economics basics'),
('Programming introduction'),
('India overview');

-- revision add 
INSERT INTO revision (page_id, text_id, user_id, description)
VALUES
(1,1,1,'Created CS page'),
(2,2,2,'Added Physics intro'),
(3,3,3,'Added Maths intro'),
(4,4,4,'Added Biology intro'),
(5,5,5,'Added Chemistry intro'),
(6,6,6,'Added Geography section'),
(7,7,7,'Added History overview'),
(8,8,8,'Added Economics overview'),
(9,9,9,'Programming basics added'),
(10,10,10,'India details added');

INSERT INTO revision (page_id, text_id, user_id, description)
VALUES
(1,1,1,'revise CS page');

update page set page_latest_id = 12 where page_id = 1;

delete from revision where rev_id = 11;
-- update the latest page id when revision change
UPDATE page SET page_latest_id = 1 WHERE page_id = 1;
UPDATE page SET page_latest_id = 2 WHERE page_id = 2;
UPDATE page SET page_latest_id = 3 WHERE page_id = 3;
UPDATE page SET page_latest_id = 4 WHERE page_id = 4;
UPDATE page SET page_latest_id = 5 WHERE page_id = 5;
UPDATE page SET page_latest_id = 6 WHERE page_id = 6;
UPDATE page SET page_latest_id = 7 WHERE page_id = 7;
UPDATE page SET page_latest_id = 8 WHERE page_id = 8;
UPDATE page SET page_latest_id = 9 WHERE page_id = 9;
UPDATE page SET page_latest_id = 10 WHERE page_id = 10;

-- logging
INSERT INTO log (user_id, log_type, action, page_id, description)
VALUES
(1,'edit','create',1,'Created article'),
(2,'edit','update',2,'Updated intro'),
(3,'edit','create',3,'Created page'),
(4,'edit','update',4,'Added new section'),
(5,'delete','delete',5,'Removed wrong text'),
(6,'move','move',6,'Page moved'),
(7,'edit','update',7,'History updated'),
(8,'protect','protect',8,'Page protected'),
(9,'edit','update',9,'Updated content'),
(10,'edit','create',10,'Created article');

-- add to watchlist
INSERT INTO watchlist (user_id, page_id)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

-- watchlist
INSERT INTO category (cat_title)
VALUES
('Science'),
('Technology'),
('Education'),
('History'),
('Geography'),
('Programming'),
('Biology'),
('Physics'),
('Mathematics'),
('India');


INSERT INTO page_categories_links (page_id, category_id)
VALUES
(1,1),
(2,8),
(3,9),
(4,7),
(5,1),
(6,5),
(7,4),
(8,3),
(9,6),
(10,10);

INSERT INTO pagelink (pl_from, pl_to)
VALUES
(1,2),
(1,3),
(2,3),
(3,9),
(4,1),
(5,2),
(6,4),
(7,5),
(8,6),
(9,10);

INSERT INTO roles (role_name, role_description)
VALUES
('Admin', 'Has full system access'),
('Normal User', 'Regular user with limited permissions');

-- insert user and role()
INSERT INTO user_roles (user_id, role_id)
VALUES
(1,1),
(2,1),
(3,2),
(4,2),
(5,2),
(6,2),
(7,2),
(8,2),
(9,2),
(10,2);

-- permissions

INSERT INTO permissions (permission_name, permission_description)
VALUES
('edit_page','edit pages'),
('delete_page','delete pages'), -- admin
('category','see type of categories'),
('create_page','create pages'),
('move_page','page title rename'),
('protect_page','protect pages'),  -- admin
('block_user','block users'),   -- admin
('view_history','view history'),
('view_page','view page'),
('view_log','see log activity'),
('manage_role','admin can manage role'), -- admin
('comment_talk_page','comment talk page'),
('watch_pages','save watch page');

-- assign permission to admin
INSERT INTO role_permissions (role_id, permission_id)
VALUES 
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),
(1,8),(1,9),(1,11),(1,12),(1,13);

-- assign permission to user
INSERT INTO role_permissions (role_id, permission_id)
VALUES
(2,3),   -- category
(2,8),   -- view_history
(2,9),   -- view_page
(2,12),  -- comment_talk_page
(2,13),  -- watch_pages
(2,1),   -- edit pages
(2,4),  -- create pages
(2,5),  -- move page(rename the page title)
(2,10);  -- view log

-- insert talk pages
INSERT INTO talk_pages (page_id, created_by)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

select * from talk_comments;

-- insert talk comments
INSERT INTO talk_comments (talk_pages_id, user_id, comment_text)
VALUES
(1,2,'Needs better references'),
(2,3,'Add diagrams please'),
(3,4,'Examples missing'),
(4,5,'Biology topic too short'),
(5,6,'Add chemical formulas'),
(6,7,'Geography map missing'),
(7,8,'History lacks detail'),
(8,9,'Economics needs data'),
(9,10,'Add code examples'),
(10,1,'India page looks excellent');






