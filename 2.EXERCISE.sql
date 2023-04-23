---- 1 - FIVE OLDEST USERS

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

---- 2. MOST POPULAR REGSTRATION DATE

SELECT 
	DAYNAME(created_at) AS created_day,
	COUNT(*) AS total
FROM users
GROUP BY created_day
ORDER BY total DESC;


---- 3. FIND USERS WHO HAVE NEVER POSTED A PHOTO

SELECT 
	username,
	image_url
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.id IS NULL;


---- 4. MOST LIKES ON A PHOTO

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


---- 5. CALCULATE AVERAGE NUMBER OF PHOTOS PER USER

SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 


---- 6. TOP FIVE MOST COMMONLY USED HASHTAG

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

---- 7. FIND BOTS WHO HAVE LIKED ALL THE PICTURES

SELECT
	users.id,
	username,
	COUNT(*) As total_likes
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = 257; 


SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) FROM   photos); 