-- Spotify Dataset --
-- Kaggle: https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset

-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes FLOAT,
    comments FLOAT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream FLOAT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA (vibe with the dataset)
SELECT COUNT (*) FROM spotify;

SELECT artist, COUNT(*) AS num_songs
FROM spotify
GROUP BY artist
ORDER BY num_songs DESC;

WITH number_songs AS (
	SELECT artist, COUNT(*) AS num_songs
	FROM spotify
	GROUP BY artist
	ORDER BY num_songs DESC
)
SELECT num_songs, COUNT(*) AS num_artists_in_group
FROM number_songs
GROUP BY num_songs
ORDER BY num_songs DESC;

SELECT DISTINCT album_type from spotify;

SELECT DISTINCT album, album_type from spotify;

SELECT MAX(duration_min) from spotify;

SELECT artist, AVG(duration_min) from spotify
GROUP BY artist
ORDER BY AVG(duration_min) ASC;

SELECT * from spotify
WHERE duration_min = 0;

DELETE FROM spotify
WHERE duration_min = 0;

SELECT DISTINCT most_played_on FROM spotify;








