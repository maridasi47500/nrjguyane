select 
 heure_chanson as heure_chanson3,filename as suiv_filename, pl3.id as playlistid3,s3.created_at as s3created, s3.title as title_suiv,s3.artist as artist_suiv, s3.id as songid3, row_number() OVER(partition by pl3.id order by ps3.id) as row_num3, max(heure_chanson) as heure_derniere_chanson3, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson3
 from playlists pl3 left join playlistsongs ps3 on ps3.playlist_id = pl3.id left join songs s3
on s3.id = ps3.song_id
union
select 
 heure_chanson as heure_chanson3,filename as suiv_filename, pl3.id as playlistid3,s3.created_at as s3created, s3.title as title_suiv,s3.artist as artist_suiv, s3.id as songid3, row_number() OVER(partition by pl3.id order by ps3.id) as row_num3, max(heure_chanson) as heure_derniere_chanson3, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson3
 from playlists pl3 left join playlistrecordings ps3 on ps3.playlist_id = pl3.id left join recordings s3
on s3.id = ps3.recording_id
group by songid3, playlistid3,s3created

order by heure_chanson asc
