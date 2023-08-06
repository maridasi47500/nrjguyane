select 
 heure_chanson as heure_chanson1,filename as prev_filename, pl1.id as playlistid1,s1.created_at as s1created, s1.title as title_prec,s1.artist as artist_prec, s1.id as songid1, row_number() OVER(partition by pl1.id order by ps1.id) as row_num1, max(heure_chanson) as heure_derniere_chanson1, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson1
 from playlists pl1 left join playlistsongs ps1 on ps1.playlist_id = pl1.id left join songs s1
on s1.id = ps1.song_id
union
select 
 heure_chanson as heure_chanson1,filename as prev_filename, pl1.id as playlistid1,s1.created_at as s1created, s1.title as title_prec,s1.artist as artist_prec, s1.id as songid1, row_number() OVER(partition by pl1.id order by ps1.id) as row_num1, max(heure_chanson) as heure_derniere_chanson1, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson1
 from playlists pl1 left join playlistrecordings ps1 on ps1.playlist_id = pl1.id left join recordings s1
on s1.id = ps1.recording_id

group by songid1, playlistid1,s1created

order by heure_chanson asc
