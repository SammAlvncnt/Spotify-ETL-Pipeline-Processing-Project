<<<<<<< HEAD
CREATE OR ALTER VIEW vw_clean_music_data AS
SELECT DISTINCT
    t.track_name, 
    a.artist_name, 
    al.album_name, 
    g.track_genre, 
    f.popularity, 
    f.duration_ms, 
    ISNULL(f.danceability, 0) AS danceability, 
    ISNULL(f.energy, 0) AS energy, 
    f.music__key, 
    ISNULL(f.loudness, 0) AS loudness, 
    f.mode, 
    ISNULL(f.speechiness, 0) AS speechiness, 
    ISNULL(f.acousticness, 0) AS acousticness, 
    ISNULL(f.instrumentalness, 0) AS instrumentalness, 
    ISNULL(f.liveness, 0) AS liveness, 
    ISNULL(f.valence, 0) AS valence, 
    ISNULL(f.tempo, 0) AS tempo, 
    f.time_signature
FROM fact_audio_features f
INNER JOIN dim_track t ON f.track_key = t.track_key
INNER JOIN dim_artist a ON f.artist_key = a.artist_key
INNER JOIN dim_album al ON f.album_key = al.album_key
INNER JOIN dim_genre g ON f.genre_key = g.genre_key
WHERE f.artist_key IS NOT NULL 
  AND f.album_key IS NOT NULL 
  AND f.track_key IS NOT NULL 
=======
CREATE OR ALTER VIEW vw_clean_music_data AS
SELECT DISTINCT
    t.track_name, 
    a.artist_name, 
    al.album_name, 
    g.track_genre, 
    f.popularity, 
    f.duration_ms, 
    ISNULL(f.danceability, 0) AS danceability, 
    ISNULL(f.energy, 0) AS energy, 
    f.music__key, 
    ISNULL(f.loudness, 0) AS loudness, 
    f.mode, 
    ISNULL(f.speechiness, 0) AS speechiness, 
    ISNULL(f.acousticness, 0) AS acousticness, 
    ISNULL(f.instrumentalness, 0) AS instrumentalness, 
    ISNULL(f.liveness, 0) AS liveness, 
    ISNULL(f.valence, 0) AS valence, 
    ISNULL(f.tempo, 0) AS tempo, 
    f.time_signature
FROM fact_audio_features f
INNER JOIN dim_track t ON f.track_key = t.track_key
INNER JOIN dim_artist a ON f.artist_key = a.artist_key
INNER JOIN dim_album al ON f.album_key = al.album_key
INNER JOIN dim_genre g ON f.genre_key = g.genre_key
WHERE f.artist_key IS NOT NULL 
  AND f.album_key IS NOT NULL 
  AND f.track_key IS NOT NULL 
>>>>>>> 7bfb31dce18d55a23acb80731692267cc2829efd
  AND f.genre_key IS NOT NULL;