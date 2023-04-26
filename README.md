
# SQL: Instagram Database Clone





## Table of Content


**1. SQL: Instagram Database Clone**
 - IG_TABLE_DATA_SCHEMA.sql
 - EXERCISE.sql
 
## Project Description

**Instagram Database Clone**

    CREATE DATABASE IG_Clone;
![1](https://user-images.githubusercontent.com/128286364/233843532-a019911d-31d5-418e-af20-ea2898697468.png)
![tables](https://user-images.githubusercontent.com/128286364/233843685-88d3f09b-5cbf-41db-9613-0ea9bbb6dab1.png)


    CREATE TABLE users (
        id INTEGER AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255) UNIQUE NOT NULL,
        created_at TIMESTAMP DEFAULT NOW()
    );
![2](https://user-images.githubusercontent.com/128286364/233843541-dfd18280-1c48-4cb5-a207-39dac0e24ea1.png)

    CREATE TABLE photos (
        id INTEGER AUTO_INCREMENT PRIMARY KEY,
        image_url VARCHAR(255) NOT NULL,
        user_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        FOREIGN KEY(user_id) REFERENCES users(id)
    );
![3](https://user-images.githubusercontent.com/128286364/233843548-62e32aab-fcd6-4495-9d75-738c2049cc59.png)


    CREATE TABLE comments (
        id INTEGER AUTO_INCREMENT PRIMARY KEY,
        comment_text VARCHAR(255) NOT NULL,
        photo_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        FOREIGN KEY(photo_id) REFERENCES photos(id),
        FOREIGN KEY(user_id) REFERENCES users(id)
    );
![4](https://user-images.githubusercontent.com/128286364/233843553-4ceed6c3-7e9d-49fb-867a-dcb5411e7631.png)

    CREATE TABLE likes (
        user_id INTEGER NOT NULL,
        photo_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        FOREIGN KEY(user_id) REFERENCES users(id),
        FOREIGN KEY(photo_id) REFERENCES photos(id),
        PRIMARY KEY(user_id, photo_id)
    );
![5](https://user-images.githubusercontent.com/128286364/233843559-333b1d41-bd3a-4a96-839b-99edac4ba065.png)

    CREATE TABLE follows (
        follower_id INTEGER NOT NULL,
        followee_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        FOREIGN KEY(follower_id) REFERENCES users(id),
        FOREIGN KEY(followee_id) REFERENCES users(id),
        PRIMARY KEY(follower_id, followee_id)
    );
![6](https://user-images.githubusercontent.com/128286364/233843565-9c6d943f-85eb-45c8-8b79-1859c5dc385b.png)

    CREATE TABLE tags (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
    );
![7](https://user-images.githubusercontent.com/128286364/233843570-6e0f38a0-a8e3-4466-ac9d-e6978fdf0f06.png)


    CREATE TABLE photo_tags (
        photo_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        FOREIGN KEY(photo_id) REFERENCES photos(id),
        FOREIGN KEY(tag_id) REFERENCES tags(id),
        PRIMARY KEY(photo_id, tag_id)
    );
![8](https://user-images.githubusercontent.com/128286364/233843576-c517cf27-5e51-45f2-b2d7-29859d6d4893.png)

**IG_Clone Exercise:**

**1. FIVE OLDEST USERS**

    SELECT *
    FROM users
    ORDER BY created_at DESC
    LIMIT 5;


    SELECT 
        username, 
        created_at 
    FROM users 
    ORDER BY created_at DESC 
    LIMIT 5;
![9](https://user-images.githubusercontent.com/128286364/233843590-b8b0abb7-52f6-4a30-b6f3-863734a76d29.png)

**2. MOST POPULAR REGSTRATION DATE**

    SELECT 
        DAYNAME(created_at) AS created_day,
        COUNT(*) AS total
    FROM users
    GROUP BY created_day
    ORDER BY total DESC;

![10](https://user-images.githubusercontent.com/128286364/233843604-afe9e559-598e-4eff-8b6f-2e346f120e76.png)

**3. FIND USERS WHO HAVE NEVER POSTED A PHOTO**

    SELECT 
        username,
        image_url
    FROM users
    LEFT JOIN photos
        ON users.id = photos.user_id
    WHERE photos.id IS NULL;
![11](https://user-images.githubusercontent.com/128286364/233843612-c7bf6621-7550-4301-9d9e-2b9352c5ca8f.png)


**4. MOST LIKES ON A PHOTO**

    SELECT 
        username,
        photos.id,
        photos.image_url, 
        COUNT(*) AS total
    FROM photos
    INNER JOIN likes
        ON likes.photo_id = photos.id
    INNER JOIN users
        ON photos.user_id = users.id
    GROUP BY photos.id
    ORDER BY total DESC
    LIMIT 1;
![12](https://user-images.githubusercontent.com/128286364/233843642-87cbbd3f-54ca-44c9-ae57-9650800458e0.png)


**5. CALCULATE AVERAGE NUMBER OF PHOTOS PER USER**

    SELECT (
        SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
        FROM   users
    ) AS avg; 
![13](https://user-images.githubusercontent.com/128286364/233843650-8cb1fa3e-bc8c-4ea5-8756-2491029a9d08.png)


**6. TOP FIVE MOST COMMONLY USED HASHTAG**

    SELECT 
        tag_name,
        tag_id,
        COUNT(*) AS total
    FROM photo_tags   
    INNER JOIN tags
        ON tags.id = photo_tags.tag_id
    GROUP BY tag_id
    ORDER BY total DESC
    LIMIT 5;
![14](https://user-images.githubusercontent.com/128286364/233843656-b6e8c9ed-6fec-4e57-a5ad-e4fa79fd48d1.png)

**7. FIND BOTS WHO HAVE LIKED ALL THE PICTURES**

    SELECT
        users.id,
        username,
        COUNT(*) As total_likes
    FROM users
    INNER JOIN likes
        ON users.id = likes.user_id
    GROUP BY users.id
    HAVING total_likes = 257; 
![15](https://user-images.githubusercontent.com/128286364/233843675-7a816512-7865-477f-a268-65e261bd6ebb.png)
    
    
## Installation

To run the program

mysq-ctl cli;

Tp create Database use faker

url: https://github.com/rivy/js.faker
