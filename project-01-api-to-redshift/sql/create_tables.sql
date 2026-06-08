CREATE TABLE demo.users (
    id BIGINT,
    name VARCHAR(200),
    username VARCHAR(100),
    email VARCHAR(200),
    phone VARCHAR(100),
    website VARCHAR(200)
);

CREATE TABLE demo.user_address (
    user_id BIGINT,
    street VARCHAR(200),
    suite VARCHAR(200),
    city VARCHAR(100),
    zipcode VARCHAR(50)
);

CREATE TABLE demo.posts (
    id BIGINT,
    userid BIGINT,
    title VARCHAR(500),
    body VARCHAR(65535)
);

CREATE TABLE demo.post_summary (
    id BIGINT,
    title_length BIGINT
);

CREATE TABLE demo.comments (
    id BIGINT,
    postid BIGINT,
    name VARCHAR(500),
    email VARCHAR(500),
    body VARCHAR(65535)
);

CREATE TABLE demo.comment_summary (
    id BIGINT,
    comment_length BIGINT
);