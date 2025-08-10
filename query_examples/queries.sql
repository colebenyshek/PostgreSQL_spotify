-- Example Questions --
-------------------------


-- 1. Retrieve the names of all tracks that have more than 1 billion streams.
SELECT track 
FROM spotify
WHERE stream > 1000000000;


-- 2. List all albums along with their respective artists.
SELECT DISTINCT album, artist 
FROM spotify
ORDER BY 1;

-- Bonus: Show all albums with >1 artist
WITH num_artist AS (
	SELECT album, count(DISTINCT artist) AS nums FROM spotify
	GROUP BY album
) 
SELECT album , nums
FROM num_artist
WHERE nums > 1;


-- 3. Get the total number of comments for tracks where licensed = TRUE.
SELECT SUM(comments) AS total_comments
FROM spotify
WHERE licensed = true;


-- 4. Find all tracks that belong to the album type single.
SELECT track, album_type
FROM spotify
WHERE album_type = 'single';

 -- Bonus: Show singles with >1 artist
SELECT track, album_type, count(*)
FROM spotify
WHERE album_type = 'single'
GROUP BY track, album_type
HAVING count(*) > 1
ORDER BY track;


-- 5. Count the total number of tracks by each artist.
SELECT artist, count(track) AS num_tracks
FROM spotify
GROUP BY artist
ORDER BY artist ASC;


-- 6. Calculate the average danceability of tracks in each album.
SELECT album, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;


-- 7. Find the top 5 tracks with the highest energy values.
SELECT DISTINCT track, energy
FROM spotify
ORDER BY energy DESC
LIMIT 5;


-- 8. List all tracks along with their views and likes where official_video = TRUE.
SELECT track, SUM(views), SUM(likes)
FROM spotify
WHERE official_video = true
GROUP BY track
ORDER BY 2 DESC;


-- 9. For each album, calculate the total views of all associated tracks.
SELECT album, track, SUM(views)
FROM spotify
GROUP BY album, track
ORDER BY 1, 3 DESC;


-- 10. Retrieve the track names that have been streamed on Spotify more than YouTube.
WITH streaming_service AS (
	SELECT 
		track,
		SUM(
			CASE
				WHEN most_played_on = 'Spotify' THEN stream
				ELSE 0
			END
		) AS spotify_streams,
		SUM(
			CASE
				WHEN most_played_on = 'Youtube' THEN stream
				ELSE 0
			END
		) AS youtube_streams
	FROM spotify
	GROUP BY 1
	ORDER BY 1
)
SELECT track, spotify_streams, youtube_streams
FROM streaming_service
WHERE spotify_streams > youtube_streams
	AND youtube_streams > 0
ORDER BY 2 DESC;

-- 11. Find the top 3 most-viewed tracks for each artist using window functions.
SELECT artist, track, total_views FROM (
	SELECT
		artist, 
		track, 
		SUM(views) AS total_views,
		DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS view_rank
	FROM spotify
	GROUP BY artist, track
) AS t1
WHERE view_rank <= 3
ORDER BY 1 ASC;


-- 12. Write a query to find tracks where the energy liveness score is above the average.
WITH cte AS (
	SELECT AVG(energy_liveness) AS liveness
	FROM spotify
)
SELECT spotify.track, spotify.energy_liveness
FROM spotify, cte
WHERE spotify.energy_liveness > cte.liveness
ORDER BY spotify.energy_liveness DESC;

-- Bonus: Shorter version
SELECT track, energy_liveness
FROM spotify
WHERE energy_liveness > (SELECT AVG(energy_liveness) FROM spotify);


-- 13. Use a WITH clause to calculate the difference between the highest and lowest energy 
--    values for tracks in each album.
WITH cte AS (
	SELECT 
		album,
		MIN(energy) AS minenergy,
		MAX(energy) AS maxenergy
	FROM Spotify
	GROUP BY album
)
SELECT album, maxenergy-minenergy AS difference
FROM cte
ORDER BY 2 DESC;


-- 14. Find tracks where the energy-to-liveness ratio is greater than 1.2.
SELECT track, artist, energy, liveness, (energy/liveness) AS el_ratio
FROM spotify
WHERE (energy / liveness) > 1.2;


-- 15. Calculate the cumulative sum of likes for tracks ordered by the number of views, 
--    using window functions.
WITH cte AS (
	SELECT *, ROW_NUMBER() OVER(PARTITION BY track) AS rn
	FROM spotify
)
SELECT
	track,
	views,
	SUM(likes) OVER(ORDER BY SUM(views)) as cumulative_likes
FROM cte
WHERE rn = 1
GROUP BY track, views, likes
ORDER BY views DESC;