# PostgreSQL_spotify
Example project using PostGRES and an example Spotify dataset

This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using SQL. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity, and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.

Data can be downloaded from [here](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset).

![Spotify logo](https://github.com/colebenyshek/PostgreSQL_spotify/blob/main/images/spotify_logo.jpg "Logo Title Text 1")

## Overview
There are three main sections to this project: (1) the initial exploration of the dataset, (2) example queries involving data retrieval, grouping, aggregations functions, and nested subqueries, and (3) optimizing query performance.

### Example Queries
Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where `licensed = TRUE`.
4. Find all tracks that belong to the album type `single`.
5. Count the total number of tracks by each artist.
6. Calculate the average danceability of tracks in each album.
7. Find the top 5 tracks with the highest energy values.
8. List all tracks along with their views and likes where `official_video = TRUE`.
9. For each album, calculate the total views of all associated tracks.
10. Retrieve the track names that have been streamed on Spotify more than YouTube.
11. Find the top 3 most-viewed tracks for each artist using window functions.
12. Write a query to find tracks where the liveness score is above the average.
13. **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
14. Find tracks where the energy-to-liveness ratio is greater than 1.2.
15. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

### Query Optimization
To improve query performance, the following optimization process was performed:

- **Initial Query Performance Analysis Using `EXPLAIN`**
    - Analyze the performance of a query using the `EXPLAIN` function.
    - The query retrieved tracks based on the `artist` column, and the performance metrics were as follows:
        - Execution time (E.T.): **1.62 ms**
        - Planning time (P.T.): **0.05 ms**
    - Below is the **screenshot** of the `EXPLAIN` result before optimization:
      ![Query before index](https://github.com/colebenyshek/PostgreSQL_spotify/blob/main/images/query_pre_index.svg)
  
- **Index Creation on the `artist` Column**
    - To optimize the query performance, create an index on the `artist` column. This ensures faster retrieval of rows where the artist is queried.
    - **SQL command** for creating the index:
      ```sql
      CREATE INDEX artist_idx ON spotify_tracks(artist);
      ```
      
- **Performance Analysis After Index Creation**
    - After creating the index, run the same query again and observed significant improvements in performance:
        - Execution time (E.T.): **0.63 ms**
        - Planning time (P.T.): **0.05 ms**
    - Below is the **screenshot** of the `EXPLAIN` result after index creation:
      ![Query after index](https://github.com/colebenyshek/PostgreSQL_spotify/blob/main/images/query_post_index.svg)
