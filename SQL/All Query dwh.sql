
USE spotify_dwh;
GO

-- 1. CLEANUP & RESET (Data Maintenance)
-- TRUNCATE TABLE fact_audio_features;

-- 2. MIGRATION (Extract & Load)
-- Pindah data dari staging ke tabel DWH
INSERT INTO fact_audio_features (track_key, artist_key, album_key, genre_key, popularity, duration_ms, danceability, energy, loudness, tempo)
SELECT track_id, artist_id, album_id, genre_id, popularity, duration_ms, danceability, energy, loudness, tempo
FROM spotify_staging.dbo.spotify_tracks_raw;
GO

-- 3. DATA CLEANSING (Imputation & Handling Missing Values)
-- Nonaktifkan FK dulu biar update gak error
ALTER TABLE fact_audio_features NOCHECK CONSTRAINT ALL;

-- Imputasi nilai NULL
UPDATE fact_audio_features SET artist_key = -1 WHERE artist_key IS NULL;
UPDATE fact_audio_features SET album_key = -1 WHERE album_key IS NULL;
UPDATE fact_audio_features SET loudness = (SELECT AVG(loudness) FROM fact_audio_features WHERE loudness IS NOT NULL) WHERE loudness IS NULL;
UPDATE fact_audio_features SET tempo = (SELECT AVG(tempo) FROM fact_audio_features WHERE tempo IS NOT NULL) WHERE tempo IS NULL;

-- Hapus Duplikat (Menggunakan CTE)
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY track_key, artist_key, album_key, genre_key ORDER BY fact_id) AS rn
    FROM fact_audio_features
)
DELETE FROM CTE WHERE rn > 1;

-- Aktifkan kembali FK
ALTER TABLE fact_audio_features WITH CHECK CHECK CONSTRAINT ALL;
GO

-- 4. MASTER AUDIT (Data Quality & Reliability Report)
-- Ini yang lu pake buat screenshot di slide presentasi
SELECT 'dim_track' AS Tabel, COUNT(*) AS Total, 
       (SELECT COUNT(*) FROM dim_track WHERE track_name IS NULL) AS Null_Data,
       (SELECT COUNT(*) FROM (SELECT track_key, COUNT(*) as cnt FROM dim_track GROUP BY track_key HAVING COUNT(*) > 1) AS T) AS Duplikat
UNION ALL
SELECT 'dim_artist', COUNT(*), 
       (SELECT COUNT(*) FROM dim_artist WHERE artist_name IS NULL),
       (SELECT COUNT(*) FROM (SELECT artist_key, COUNT(*) as cnt FROM dim_artist GROUP BY artist_key HAVING COUNT(*) > 1) AS T)
UNION ALL
SELECT 'dim_album', COUNT(*), 
       (SELECT COUNT(*) FROM dim_album WHERE album_name IS NULL),
       (SELECT COUNT(*) FROM (SELECT album_key, COUNT(*) as cnt FROM dim_album GROUP BY album_key HAVING COUNT(*) > 1) AS T)
UNION ALL
SELECT 'dim_genre', COUNT(*), 
       (SELECT COUNT(*) FROM dim_genre WHERE track_genre IS NULL),
       (SELECT COUNT(*) FROM (SELECT genre_key, COUNT(*) as cnt FROM dim_genre GROUP BY genre_key HAVING COUNT(*) > 1) AS T)
UNION ALL
SELECT 'fact_audio_features', COUNT(*), 
       (SELECT COUNT(*) FROM fact_audio_features WHERE track_key IS NULL OR artist_key IS NULL OR album_key IS NULL OR genre_key IS NULL),
       (SELECT COUNT(*) FROM (SELECT track_key, artist_key, album_key, genre_key, COUNT(*) as cnt FROM fact_audio_features GROUP BY track_key, artist_key, album_key, genre_key HAVING COUNT(*) > 1) AS T);
GO

-- 5. PREVIEW DATA (Validasi Visual)
SELECT TOP 10 * FROM fact_audio_features;
GO