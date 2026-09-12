
-- USER TABLE

create database wekipedia;
use wekipedia;
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255)  NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) Unique Not NULL,
    register_date_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- PAGE TABLE

CREATE TABLE page (
    page_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT, 
    page_title VARCHAR(255) NOT NULL,
	page_type varchar(50) Not null,
    page_namespace INT DEFAULT 0,
	page_latest_id INT -- points to latest revision store latest revision id
);

CREATE TABLE page_restrictions (
    pr_id INT AUTO_INCREMENT PRIMARY KEY,
    page_id INT NOT NULL,                   -- which page is restricted
    type_restrict VARCHAR(60) NOT NULL,           -- type of restriction (edit, move, create)
    level VARCHAR(60) NOT NULL,          -- restriction level (sysop, autoconfirmed)
    reason TEXT,                         -- why the restriction was applied
    FOREIGN KEY (page_id) REFERENCES page(page_id) ON DELETE CASCADE
);
CREATE TABLE block (
    block_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT NOT NULL,               -- who applied the block (admin)
    user_id INT NOT NULL,                 -- which user (or IP) is blocked
    reason VARCHAR(100),                         -- reason for the block
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,  -- when it was applied
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- REVISION TABLE
-- One user → many revisions
-- One page → many revisions

-- TEXT TABLE
CREATE TABLE text (
    old_id INT AUTO_INCREMENT PRIMARY KEY,
    old_text VARCHAR(100) NOT NULL
);

CREATE TABLE revision (
    rev_id INT AUTO_INCREMENT PRIMARY KEY,
    page_id INT NOT NULL,        -- which page this revision belongs to
    text_id INT NOT NULL,     -- text of this revision
    user_id INT NOT NULL,      -- who made this revision (FK to user table)
    description VARCHAR(100),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (page_id) REFERENCES page(page_id) ON DELETE CASCADE,
    FOREIGN KEY (text_id) REFERENCES text(old_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- LOGGING TABLE
-- One user → many logs
CREATE TABLE log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    log_type VARCHAR(50),
    action VARCHAR(50),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    page_id INT,
    description VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (page_id) REFERENCES page(page_id) 
);

-- WATCHLIST TABLE
-- One user → many watchlist entries
CREATE TABLE watchlist (
    wl_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    page_id INT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (page_id) REFERENCES page(page_id) ON DELETE CASCADE
);

-- CATEGORY TABLE

CREATE TABLE category (
    cat_id INT AUTO_INCREMENT PRIMARY KEY,
    cat_title VARCHAR(255) NOT NULL UNIQUE
);

-- CATEGORYLINKS TABLE
-- Many Pages ↔ Many Categories

CREATE TABLE page_categories_links (
    page_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (page_id, category_id),
    FOREIGN KEY (page_id) REFERENCES page(page_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(cat_id) ON DELETE CASCADE
);

-- PAGELINK TABLE
-- One page → many pagelinks (internal links)

CREATE TABLE pagelink (
    pl_id INT AUTO_INCREMENT PRIMARY KEY,
    pl_from INT NOT NULL,   -- source page
    pl_to INT NOT NULL,     -- target page
    FOREIGN KEY (pl_from) REFERENCES page(page_id) ON DELETE CASCADE,
    FOREIGN KEY (pl_to) REFERENCES page(page_id) ON DELETE CASCADE
);

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL UNIQUE,
    role_description TEXT
);
CREATE TABLE user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);
CREATE TABLE permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(100) NOT NULL UNIQUE,
    permission_description TEXT
);
CREATE TABLE role_permissions (
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id)
);

CREATE TABLE talk_pages (
    talk_id INT AUTO_INCREMENT PRIMARY KEY,
    page_id INT NOT NULL,                 -- connects to the article/page being discussed
    created_by INT NOT NULL,              -- user who started the talk page
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (page_id) REFERENCES page(page_id),
    FOREIGN KEY (created_by) REFERENCES user(user_id)
);
CREATE TABLE talk_comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    talk_pages_id INT NOT NULL,                  -- the talk page this comment belongs to
    user_id INT NOT NULL,                  -- who wrote it
    parent_comment_id INT DEFAULT NULL,    -- NULL = top-level comment, else a reply
    comment_text TEXT NOT NULL,            -- the actual discussion content
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (talk_pages_id) REFERENCES talk_pages(talk_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (parent_comment_id) REFERENCES talk_comments(comment_id)
);
show tables;


