-- Query Optimization --
------------------------

-- Simple example showing the use of an index to improve performance


-- Query
EXPLAIN ANALYZE
SELECT
	artist,
	track,
	stream
FROM spotify
WHERE artist = 'Gorillaz'
ORDER BY stream DESC
LIMIT 10;

-- Index Creation
CREATE INDEX artist_idx ON spotify(artist);

-- Pre-index: ET=1.62ms, PT=0.05ms
-- Post-index: ET=0.63ms, PT=0.05ms (~61.1% faster ET)