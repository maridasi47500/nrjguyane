select ps.heure_chanson, 
songs.duree,strftime("%H:%M:%S","now") as now,
songs.created_at as songscreatedat,cast(strftime("%s","now") as float) - cast(strftime("%s",ps.heure_chanson) as float) as moment_dans_chanson,
cast(strftime("%s",ps.heure_chanson) as float) as debut_chanson,
cast(strftime("%s",ps.heure_chanson) as float) + songs.duree as madureetotale, playlists.id as playlistid,cast(strftime("%s","now") as float) as timenow, songs.id as songid, row_number() OVER(partition by playlists.id order by ps.id) as row_num, max(heure_chanson) as heure_derniere_chanson, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson  from playlists left join playlistsongs ps on ps.playlist_id = playlists.id left join songs on        songs.id = ps.song_id group by songid, playlistid;

