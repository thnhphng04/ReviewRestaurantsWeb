create database SWP_Project;

use SWP_Project;

CREATE TABLE accountDetail (
    account_id INT PRIMARY KEY identity (1,1),
    password NVARCHAR(255) NOT NULL,
	gender bit not null,
    phone_number NVARCHAR(20),
	dob Date,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    role INT NOT NULL,
	avatar VARBINARY(MAX),
	status int not null,
	verifyCode int,
);

CREATE TABLE account_follower (
    account_id INT,
    follower_id INT,
    PRIMARY KEY (account_id, follower_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id),
    FOREIGN KEY (follower_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE restaurant (
    restaurant_id INT PRIMARY KEY,
	name NVARCHAR(255) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(20),
    lowest_price int,
    highest_price int,
    open_time TIME,
    close_time TIME,
	avatar VARBINARY(MAX),
	status int not null,
	account_id INT,
	edit_of int,
	reason_deny NVARCHAR(MAX),
	FOREIGN KEY (edit_of) REFERENCES restaurant(restaurant_id),
	FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE restaurant_proof_media (
    media_id INT PRIMARY KEY,
	restaurant_id INT,
    media_data VARBINARY(MAX) NOT NULL,
	FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id)
);

CREATE TABLE post (
    post_id INT PRIMARY KEY,
    account_id INT,
	restaurant_id int,
    title NVARCHAR(255) NOT NULL,
    date DATETIME NOT NULL,
    text NVARCHAR(MAX),
    rating FLOAT,
	status int not null,
	service_rate float,
	price_rate float,
	space_rate float,
	taste_rate float,
	hygiene_rate float,
	edit_of int,
	reason_deny NVARCHAR(MAX),
	FOREIGN KEY (edit_of) REFERENCES post(post_id),
	FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id),
);

CREATE TABLE comment (
    comment_id INT PRIMARY KEY,
    post_id INT,
    account_id INT,
    text NVARCHAR(MAX) NOT NULL,
	date DATETIME NOT NULL,
	status int not null,
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE comment_react (
    comment_id INT,
    account_id INT,
	PRIMARY KEY (comment_id , account_id),
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE reply (
    reply_id INT PRIMARY KEY,
    comment_id INT,
    account_id INT,
    text NVARCHAR(MAX) NOT NULL,
	date DATETIME NOT NULL,
	status int not null,
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE reply_react (
    reply_id INT,
    account_id INT,
	PRIMARY KEY (reply_id , account_id),
    FOREIGN KEY (reply_id) REFERENCES reply(reply_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE comment_report (
    comment_report_id INT PRIMARY KEY,
    comment_id INT,
    account_id INT,
    type_of_report INT NOT NULL,
    text NVARCHAR(MAX) NOT NULL,
	date DATETIME NOT NULL,
	status int not null,
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE post_report (
    post_report_id INT PRIMARY KEY,
    post_id INT,
    account_id INT,
    type_of_report INT NOT NULL,
    text NVARCHAR(MAX) NOT NULL,
	date DATETIME NOT NULL,
	status int not null,
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE restaurant_report (
    restaurant_report_id INT PRIMARY KEY,
    restaurant_id INT,
    account_id INT,
    type_of_report INT NOT NULL,
    text NVARCHAR(MAX) NOT NULL,
	date DATETIME NOT NULL,
	status int not null,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE post_proof_media (
    media_id INT PRIMARY KEY,
    post_id INT,
	restaurant_id INT,
    media_data VARBINARY(MAX) NOT NULL,
    FOREIGN KEY (post_id) REFERENCES post(post_id),
	FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id)
);

CREATE TABLE media (
    media_id INT PRIMARY KEY,
    post_id INT,
	restaurant_id INT,
    media_data VARBINARY(MAX) NOT NULL,
    FOREIGN KEY (post_id) REFERENCES post(post_id),
	FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id)
);

CREATE TABLE type_of_meal (
    type_of_meal_id INT,
    post_id INT,
	PRIMARY KEY (type_of_meal_id, post_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

CREATE TABLE type_of_food (
    type_of_food_id INT,
    post_id INT,
	PRIMARY KEY (type_of_food_id, post_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

CREATE TABLE react (
    post_id INT,
    account_id INT,
	PRIMARY KEY (post_id , account_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);

CREATE TABLE post_saved (
    post_id INT,
    account_id INT,
	PRIMARY KEY (post_id , account_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (account_id) REFERENCES accountDetail(account_id)
);








