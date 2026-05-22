<<<<<<< HEAD
SELECT 'dim_artist' AS table_name, COUNT(*) - COUNT(DISTINCT artist_key) AS total_duplicate FROM dim_artist
UNION ALL
SELECT 'dim_album', COUNT(*) - COUNT(DISTINCT album_key) FROM dim_album
UNION ALL
SELECT 'dim_track', COUNT(*) - COUNT(DISTINCT track_key) FROM dim_track
UNION ALL
SELECT 'dim_genre', COUNT(*) - COUNT(DISTINCT genre_key) FROM dim_genre
UNION ALL
SELECT 'fact_audio_features', COUNT(*) - COUNT(DISTINCT fact_id) FROM fact_audio_features;

SELECT 'dim_artist' AS table_name, SUM(CASE WHEN artist_key IS NULL OR artist_name IS NULL THEN 1 ELSE 0 END) AS total_null FROM dim_artist
UNION ALL
SELECT 'dim_album', SUM(CASE WHEN album_key IS NULL OR album_name IS NULL THEN 1 ELSE 0 END) FROM dim_album
UNION ALL
SELECT 'dim_track', SUM(CASE WHEN track_key IS NULL OR track_name IS NULL THEN 1 ELSE 0 END) FROM dim_track
UNION ALL
SELECT 'dim_genre', SUM(CASE WHEN genre_key IS NULL OR track_genre IS NULL THEN 1 ELSE 0 END) FROM dim_genre
UNION ALL
SELECT 'fact_audio_features', SUM(CASE WHEN artist_key IS NULL OR album_key IS NULL OR track_key IS NULL OR genre_key IS NULL THEN 1 ELSE 0 END) FROM fact_audio_features;

=======
SELECT 'dim_artist' AS table_name, COUNT(*) - COUNT(DISTINCT artist_key) AS total_duplicate FROM dim_artist
UNION ALL
SELECT 'dim_album', COUNT(*) - COUNT(DISTINCT album_key) FROM dim_album
UNION ALL
SELECT 'dim_track', COUNT(*) - COUNT(DISTINCT track_key) FROM dim_track
UNION ALL
SELECT 'dim_genre', COUNT(*) - COUNT(DISTINCT genre_key) FROM dim_genre
UNION ALL
SELECT 'fact_audio_features', COUNT(*) - COUNT(DISTINCT fact_id) FROM fact_audio_features;

SELECT 'dim_artist' AS table_name, SUM(CASE WHEN artist_key IS NULL OR artist_name IS NULL THEN 1 ELSE 0 END) AS total_null FROM dim_artist
UNION ALL
SELECT 'dim_album', SUM(CASE WHEN album_key IS NULL OR album_name IS NULL THEN 1 ELSE 0 END) FROM dim_album
UNION ALL
SELECT 'dim_track', SUM(CASE WHEN track_key IS NULL OR track_name IS NULL THEN 1 ELSE 0 END) FROM dim_track
UNION ALL
SELECT 'dim_genre', SUM(CASE WHEN genre_key IS NULL OR track_genre IS NULL THEN 1 ELSE 0 END) FROM dim_genre
UNION ALL
SELECT 'fact_audio_features', SUM(CASE WHEN artist_key IS NULL OR album_key IS NULL OR track_key IS NULL OR genre_key IS NULL THEN 1 ELSE 0 END) FROM fact_audio_features;

>>>>>>> 7bfb31dce18d55a23acb80731692267cc2829efd
SELECT * FROM vw_clean_music_data;