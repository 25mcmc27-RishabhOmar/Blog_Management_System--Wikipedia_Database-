# Blog Management System (Wikipedia Database)

A MySQL-based relational database project designed to model the core functionality of a Wikipedia-like collaborative content management system.

## Project Overview

The Blog Management System (Wikipedia Database) manages users, roles, permissions, pages, revisions, text content, categories, watchlists, talk pages, comments, logs, blocks, page links, and page restrictions.

The project demonstrates practical implementation of relational database concepts using MySQL and SQL.

## Features

- User registration and user management
- Role and permission management
- Page creation and management
- Page revision and version history
- Text content management
- Page categorisation
- User watchlists
- Page-to-page internal links
- Talk pages and comments
- Threaded comment replies
- User blocking
- Page restrictions
- Activity and administrative logging
- SQL joins and combined queries
- Page and content search
- Administrative statistics

## Database Schema

The database contains the following main tables:

- `User`
- `Roles`
- `Permission`
- `User_role`
- `role_permission`
- `Page`
- `Revision`
- `Text`
- `Watchlist`
- `Category`
- `Page_category_link`
- `Page_Link`
- `Talk_page`
- `Talk_Comment`
- `Log`
- `Block`
- `Page_restriction`

## Entity Relationships

The database implements several types of relationships:

### User and Roles
Users are assigned roles through the `User_role` bridge table.

**Relationship:** Many-to-Many

### Roles and Permissions
Roles are associated with permissions through the `role_permission` bridge table.

**Relationship:** Many-to-Many

### User and Revision
A user can create multiple revisions.

**Relationship:** One-to-Many

### Page and Revision
A page can have multiple revisions, while each revision belongs to one page.

**Relationship:** One-to-Many

### Revision and Text
Each revision is associated with the text content of that version.

**Relationship:** One-to-One

### User and Page through Watchlist
Users can watch multiple pages, and a page can be watched by multiple users.

**Relationship:** Many-to-Many

### Page and Category
Pages can belong to multiple categories through `Page_category_link`.

**Relationship:** Many-to-Many

### Page and Talk Page
A page can have an associated talk page for discussions.

**Relationship:** One-to-One

### Talk Page and Comments
A talk page can contain multiple comments.

**Relationship:** One-to-Many

### Comments and Replies
Comments can reference other comments to support threaded discussions.

**Relationship:** Self-Referencing

## Main Functional Workflows

### 1. Page Edit and Revision Flow

When a user edits a page:

1. New text content is inserted into the `Text` table.
2. A new revision is created in the `Revision` table.
3. The revision stores the page, text, user, description, and timestamp.
4. The page's latest revision ID is updated.
5. Previous revisions remain available for revision history.

Example:

```sql
INSERT INTO revision 
(page_id, text_id, user_id, description)
VALUES 
(2, 13, 2, 'Change the topic of physics');

UPDATE page
SET page_latest_id = 15
WHERE page_id = 2;

2. View Revision History
SELECT r.rev_id,
       u.user_name,
       r.description,
       r.timestamp
FROM revision r
JOIN user u
ON r.user_id = u.user_id
WHERE r.page_id = 1;

3. Display Pages with Categories
SELECT p.page_title,
       c.cat_title
FROM page_category_link pcl
JOIN page p
ON pcl.page_id = p.page_id
JOIN category c
ON pcl.category_id = c.cat_id;

4. View Users and Their Roles
SELECT u.user_name,
       r.role_name
FROM user_role ur
JOIN user u
ON ur.user_id = u.user_id
JOIN roles r
ON ur.role_id = r.role_id;

5. View User Permissions
SELECT p.permission_name
FROM user_role ur
JOIN role_permission rp
ON ur.role_id = rp.role_id
JOIN permission p
ON rp.permission_id = p.permission_id
WHERE ur.user_id = 1;

6. View Blocked Users and Administrators
SELECT a.user_name AS admin,
       u.user_name AS blocked_user,
       b.reason,
       b.timestamp
FROM block b
JOIN user a
ON b.admin_id = a.user_id
JOIN user u
ON b.user_id = u.user_id;

7. Display Latest Page Content
SELECT p.page_title,
       t.old_text,
       r.timestamp
FROM page p
JOIN revision r
ON p.page_latest_id = r.rev_id
JOIN text t
ON r.text_id = t.old_id;

8. View Activity Logs
SELECT l.log_id,
       u.user_name,
       l.log_type,
       l.action,
       l.description,
       l.timestamp
FROM log l
JOIN user u
ON l.user_id = u.user_id;

9. Find Internal Links Between Pages
SELECT a.page_title AS from_page,
       b.page_title AS to_page
FROM page_link pl
JOIN page a
ON pl.pl_from = a.page_id
JOIN page b
ON pl.pl_to = b.page_id;

10. View Talk Page Comments
SELECT c.comment_id,
       u.user_name,
       c.comment_text,
       c.parent_comment_id,
       c.created_at
FROM talk_comment c
JOIN user u
ON c.user_id = u.user_id
WHERE c.talk_page_id = 1
ORDER BY c.created_at;
