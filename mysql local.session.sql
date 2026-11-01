CREATE DATABASE IF NOT EXISTS MovieDB;

USE MovieDB;

CREATE TABLE IF NOT EXISTS Directors (
    director_id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(100),
    nationality VARCHAR(50),
    birth_year INT
);

CREATE TABLE IF NOT EXISTS Actors (
    actor_id INT PRIMARY KEY AUTO_INCREMENT,
    actor_name VARCHAR(100),
    age INT,
    nationality VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(100),
    genre VARCHAR(50),
    release_year INT,
    rating DECIMAL(3,1),
    budget DECIMAL(12,2),
    director_id INT,
    FOREIGN KEY (director_id) REFERENCES Directors(director_id)
);

CREATE TABLE IF NOT EXISTS Movie_Actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors(actor_id)
);

CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    email VARCHAR(100),
    age INT
);

CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    review_text VARCHAR(500),
    rating DECIMAL(3,1),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

INSERT INTO Directors (director_name, nationality, birth_year)
VALUES
('Christopher Nolan', 'British', 1970),
('Rajkumar Hirani', 'Indian', 1962),
('S. S. Rajamouli', 'Indian', 1973),
('Denis Villeneuve', 'Canadian', 1967);

INSERT INTO Actors (actor_name, age, nationality)
VALUES
('Leonardo DiCaprio', 51, 'American'),
('Cillian Murphy', 50, 'Irish'),
('Aamir Khan', 61, 'Indian'),
('Prabhas', 47, 'Indian'),
('Ram Charan', 41, 'Indian'),
('Timothee Chalamet', 30, 'American'),
('Christian Bale', 52, 'British');

INSERT INTO Movies (movie_name, genre, release_year, rating, budget, director_id)
VALUES
('Inception', 'Sci-Fi', 2010, 8.8, 160000000, 1),
('Interstellar', 'Sci-Fi', 2014, 8.7, 165000000, 1),
('3 Idiots', 'Comedy', 2009, 8.4, 5500000, 2),
('RRR', 'Action', 2022, 7.8, 72000000, 3),
('Bahubali', 'Action', 2015, 8.0, 25000000, 3),
('Dune', 'Sci-Fi', 2021, 8.0, 165000000, 4),
('Oppenheimer', 'Drama', 2023, 8.3, 100000000, 1);

INSERT INTO Movie_Actors (movie_id, actor_id)
VALUES
(1, 1),
(1, 7),
(2, 7),
(3, 3),
(4, 4),
(4, 5),
(5, 4),
(6, 6),
(7, 2);

INSERT INTO Users (username, email, age)
VALUES
('Kunal', 'kunal@gmail.com', 19),
('Rahul', 'rahul@gmail.com', 21),
('Aman', 'aman@gmail.com', 22),
('Priya', 'priya@gmail.com', 20);

INSERT INTO Reviews (user_id, movie_id, review_text, rating)
VALUES
(1, 1, 'Amazing concept', 9.0),
(1, 2, 'Mind blowing movie', 9.5),
(2, 3, 'Great comedy', 8.5),
(2, 4, 'Excellent action', 8.0),
(3, 5, 'Great visual effects', 8.5),
(4, 6, 'Amazing cinematography', 9.0);

SELECT * FROM Movies;

SELECT movie_name, rating FROM Movies;

SELECT DISTINCT genre FROM Movies;

SELECT movie_name AS Title, rating AS Movie_Rating
FROM Movies;

SELECT * FROM Movies
WHERE rating > 8.0;

SELECT * FROM Movies
WHERE genre = 'Sci-Fi';

SELECT * FROM Movies
WHERE release_year >= 2015;

SELECT * FROM Movies
WHERE rating != 8.0;

SELECT * FROM Movies
WHERE rating > 8.0 AND release_year > 2010;

SELECT * FROM Movies
WHERE genre = 'Action' OR genre = 'Comedy';

SELECT * FROM Movies
WHERE NOT genre = 'Drama';

SELECT * FROM Movies
WHERE rating BETWEEN 8.0 AND 9.0;

SELECT * FROM Movies
WHERE genre IN ('Action', 'Sci-Fi');

SELECT * FROM Movies
WHERE movie_name LIKE 'I%';

SELECT * FROM Movies
WHERE movie_name LIKE '%a%';

SELECT * FROM Movies
ORDER BY rating DESC;

SELECT * FROM Movies
ORDER BY release_year ASC;

SELECT * FROM Movies
ORDER BY rating DESC
LIMIT 3;

SELECT COUNT(*) FROM Movies;

SELECT MAX(rating) FROM Movies;

SELECT MIN(rating) FROM Movies;

SELECT AVG(rating) FROM Movies;

SELECT SUM(budget) FROM Movies;

SELECT genre, COUNT(*) AS Total_Movies
FROM Movies
GROUP BY genre;

SELECT director_id, AVG(rating) AS Average_Rating
FROM Movies
GROUP BY director_id;

SELECT genre, COUNT(*) AS Total_Movies
FROM Movies
GROUP BY genre
HAVING COUNT(*) > 1;

SELECT Movies.movie_name, Directors.director_name
FROM Movies
INNER JOIN Directors
ON Movies.director_id = Directors.director_id;

SELECT Movies.movie_name, Directors.director_name
FROM Movies
LEFT JOIN Directors
ON Movies.director_id = Directors.director_id;

SELECT Movies.movie_name, Actors.actor_name
FROM Movies
INNER JOIN Movie_Actors
ON Movies.movie_id = Movie_Actors.movie_id
INNER JOIN Actors
ON Movie_Actors.actor_id = Actors.actor_id;

SELECT * FROM Movies
WHERE rating > (
    SELECT AVG(rating)
    FROM Movies
);

SELECT * FROM Movies
WHERE director_id IN (
    SELECT director_id
    FROM Directors
    WHERE nationality = 'Indian'
);

SELECT UPPER(movie_name) FROM Movies;

SELECT LOWER(movie_name) FROM Movies;

SELECT LENGTH(movie_name) FROM Movies;

SELECT CONCAT(movie_name, ' - ', genre)
FROM Movies;

SELECT ROUND(AVG(rating), 2)
FROM Movies;

SELECT CEIL(AVG(rating))
FROM Movies;

SELECT FLOOR(AVG(rating))
FROM Movies;

UPDATE Movies
SET rating = 9.0
WHERE movie_id = 1;

DELETE FROM Reviews
WHERE review_id = 6;

ALTER TABLE Movies
ADD language VARCHAR(50);

ALTER TABLE Movies
MODIFY language VARCHAR(100);

ALTER TABLE Movies
DROP COLUMN language;

CREATE VIEW MovieDetails AS
SELECT Movies.movie_name, Movies.genre,
Movies.rating, Directors.director_name
FROM Movies
INNER JOIN Directors
ON Movies.director_id = Directors.director_id;

SELECT * FROM MovieDetails;

SHOW TABLES;

DESCRIBE Movies;

SELECT * FROM Movies;

SELECT * FROM Directors;

SELECT * FROM Actors;

SELECT * FROM Users;

SELECT * FROM Reviews;

SELECT * FROM Movie_Actors;