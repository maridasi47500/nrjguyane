class Song < ApplicationRecord
  has_and_belongs_to_many :playlists, :join_table => :playlistsongs
  def image
    read_attribute(:image) || "no_album_art.png"
  end
  def duration
    t = Thread.new do
    @aa = `ffprobe -print_format json -show_streams -show_format -v error #{Rails.root.to_s+"/public/uploads/"+filename}`
        end
      t.join
    
    @aa
  rescue
    "my error"
  end
  def self.findmysong(mydate)
    offset_utc=DateTime.now.formatted_offset(false).gsub("0","")
    x=offset_utc.to_i
    y=(-x)
    z=(y > 0 ? "+" : "")+y.to_s
   
    p z+" hours"
    mydate=DateTime.parse(mydate.to_s) - 2.hours
    
     @a=ActiveRecord::Base.connection.execute(send(:sanitize_sql_array, ["
      select playlistid,title,artist,heure_chanson, madureetotale,debut_chanson,moment_dans_chanson,now,
artist_suiv_2,title_suiv_2, suiv_filename_nb2,heure_chanson1,heure_chanson3,
artist_suiv_3, title_suiv_3, suiv_filename_nb3,image1st, image2, image3,heurechansonnow,heurechansonnow2,heurechansonnow3,
duree,filename, songid, playlistid,timenow,heure_derniere_chanson

    from (select playlists.*, strftime('%H:%M',datetime(ps.heure_chanson, '#{offset_utc} hours'))  as heurechansonnow,ps.heure_chanson, songs.duree,strftime('%H:%M:%S','now') as now,cast(strftime('%s','now') as float) - cast(strftime('%s',ps.heure_chanson) as float) as moment_dans_chanson,cast(strftime('%s',ps.heure_chanson) as float) as debut_chanson,cast(strftime('%s',ps.heure_chanson) as float) + songs.duree as madureetotale, playlists.id as playlistid,cast(strftime('%s','now') as float) as timenow, songs.*, songs.id as songid, row_number() OVER(partition by playlists.id order by ps.id) as row_num, max(heure_chanson) as heure_derniere_chanson,ifnull(songs.image, 'no_album_art.png') as image1st, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson
 from playlists left join playlistsongs ps on ps.playlist_id = playlists.id left join songs on        songs.id = 
ps.song_id
group by songid,playlist_id

order by heure_chanson asc

) t1 
left outer join (
select 
 heure_chanson as heure_chanson1,strftime('%H:%M',datetime(ps1.heure_chanson, '#{offset_utc} hours'))  as heurechansonnow2,filename as suiv_filename_nb2, pl1.id as playlistid1, s1.title as title_suiv_2,s1.artist as artist_suiv_2, s1.id as songid1, row_number() OVER(partition by pl1.id order by ps1.id) as row_num1, max(heure_chanson) as heure_derniere_chanson1, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson1, ifnull(s1.image, 'no_album_art.png') as image2
 from playlists pl1 left join playlistsongs ps1 on ps1.playlist_id = pl1.id left join songs s1
on s1.id = ps1.song_id
group by songid1,playlistid1

order by heure_chanson asc
)t2_suiv on t2_suiv.heure_chanson1 > t1.heure_chanson
left outer join (
select 
 ps3.heure_chanson as heure_chanson3,ifnull(s3.image, 'no_album_art.png') as image3,filename as suiv_filename_nb3, pl3.id as playlistid3, s3.title as title_suiv_3,s3.artist as artist_suiv_3,strftime('%H:%M',datetime(ps3.heure_chanson,'#{offset_utc} hours'))  as heurechansonnow3,  s3.id as songid3, row_number() OVER(partition by pl3.id order by ps3.id) as row_num3, max(heure_chanson) as heure_derniere_chanson3, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson3
 from playlists pl3 left join playlistsongs ps3 on ps3.playlist_id = pl3.id left join songs s3
on s3.id = ps3.song_id
group by songid3,playlistid3

order by heure_chanson asc
)t3_suiv on t3_suiv.heure_chanson3 > t2_suiv.heure_chanson1

group by songid, playlistid
having (cast(strftime('%s',heure_chanson) as float)+duree > cast(strftime('%s', ?) as float))
and (cast(strftime('%s',heure_chanson) as float) < cast(strftime('%s', ?) as float))
order by cast(strftime('%s', DATETIME(heure_chanson, '#{z} hours')) as float) asc

 
      ", mydate,mydate]))
p @a[0]
  if @a[0]
    @a.take(3)
  else
    []
  end
  end
  def filename=(uploaded_io)
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    write_attribute(:filename, uploaded_io.original_filename)
  end
  def filename
    read_attribute(:filename)
  end

end
