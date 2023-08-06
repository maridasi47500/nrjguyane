class Playlist < ApplicationRecord
  after_update :poiuytre
  def poiuytre
    x=self.playlistsongs.to_a+self.playlistrecordings.to_a
    y=x.select{|h|h.heure_chanson}.sort_by{|h|h.heure_chanson}
    z=x.select{|h|!h.heure_chanson}
    @duration=0.0
    z.each do |h|

      h.update(heure_chanson: h.playlist.heure_playlist+@duration.second)
      if h.is_a?(Playlistsong)
      @duration+=h.song.duree
      else
      @duration+=h.recording.duree
      end
    end

    
  end
  has_and_belongs_to_many :emissions, :join_table => :playlistemissions
  accepts_nested_attributes_for :emissions,allow_destroy: true
  has_many :playlistsongs, dependent: :destroy
  has_many :songs, :through => :playlistsongs
  has_many :playlistrecordings, dependent: :destroy
  has_many :recordings, :through => :playlistrecordings
  accepts_nested_attributes_for :songs,allow_destroy: true
  after_create :azerty
  before_validation :tyuiop
  def tyuiop
    @a=Playlist.joins(:playlistsongs).joins("left join songs on songs.id = playlistsongs.song_id").select("playlists.*, heure_chanson, playlists.id as playlistid, songs.*, songs.id as songid, row_number() OVER(partition by playlists.id order by playlistsongs.id) as row_num, max(heure_chanson) as heure_derniere_chanson, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson").group("playlistid").having("duree_derniere_chanson <> 0") 
    p "zertyuiofghjk", @a[0].as_json
    if @a[0]
      a=DateTime.parse(@a[0].heure_derniere_chanson).to_f+@a[0].duree_derniere_chanson.second
      if a<DateTime.now.to_f
        self.heure_playlist=DateTime.now
      else
        self.heure_playlist=a
      end
    else
      self.heure_playlist=DateTime.now
    end
  rescue => e
    p e.message
    p "ertyui"
  end
  def azerty

  end
  def self.myplaylist
    @a=Playlist.joins(:playlistsongs).joins("left join songs on songs.id = playlistsongs.song_id").select("playlists.*, heure_chanson, playlists.id as playlistid, songs.*,cast(strftime('%s','now') as float) as timenow, songs.id as songid, row_number() OVER(partition by playlists.id order by playlistsongs.id) as row_num, max(heure_chanson) as heure_derniere_chanson, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson").group("songid, playlistid").order("heure_chanson asc").having("(cast(strftime('%s',heure_chanson) as float)+duree) > ?", DateTime.now.to_f)
   
    if @a[0]
      
      x= DateTime.now.to_f - (DateTime.parse(@a[0].heure_chanson).to_f) 
      p x
      if x > 0 and @a.length > 0
        {song: @a[0].as_json, maduree: (x)}
      else
        {}
      end
    else
      {}
    end
  end
  def self.myotherplaylist
   
    @a=ActiveRecord::Base.connection.execute(send(:sanitize_sql_array, ["
      select playlistid,title,artist,heure_chanson, madureetotale,debut_chanson,moment_dans_chanson,now,
artist_prec,title_prec, prev_filename,
artist_suiv,title_suiv, suiv_filename,
duree,filename, songid, playlistid,timenow,heure_derniere_chanson

    from (

select 
playlists.*, ps.heure_chanson, songs.duree,strftime('%H:%M:%S','now')  as now,songs.created_at as songscreatedat,cast(strftime('%s','now') as float) - cast(strftime('%s',ps.heure_chanson) as float) as moment_dans_chanson,cast(strftime('%s',ps.heure_chanson) as float) as debut_chanson,cast(strftime('%s',ps.heure_chanson) as float) + songs.duree as madureetotale, playlists.id as playlistid,cast(strftime('%s','now') as float) as timenow, songs.id as songid, row_number() OVER(partition by playlists.id order by ps.id) as row_num, max(heure_chanson) as heure_derniere_chanson, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson, songs.title, songs.artist, songs.filename
 from playlists 
left join playlistsongs ps on ps.playlist_id = playlists.id left join songs on        songs.id = ps.song_id
union all
select playlists.*, ps.heure_chanson, songs.duree,strftime('%H:%M:%S','now')  as now,songs.created_at as songscreatedat,cast(strftime('%s','now') as float) - cast(strftime('%s',ps.heure_chanson) as float) as moment_dans_chanson,cast(strftime('%s',ps.heure_chanson) as float) as debut_chanson,cast(strftime('%s',ps.heure_chanson) as float) + songs.duree as madureetotale, playlists.id as playlistid,cast(strftime('%s','now') as float) as timenow, songs.id as songid, row_number() OVER(partition by playlists.id order by ps.id) as row_num, max(heure_chanson) as heure_derniere_chanson, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson, songs.title, songs.artist, songs.filename
 from playlists 
left join playlistrecordings ps on ps.playlist_id = playlists.id left join recordings songs on        songs.id = ps.recording_id

group by songid, playlistid, songscreatedat

order by heure_chanson asc

) t1 
left outer join (

select 
 heure_chanson as heure_chanson1,filename as prev_filename, pl1.id as playlistid1,s1.created_at as s1created, s1.title as title_prec,s1.artist as artist_prec, s1.id as songid1, row_number() OVER(partition by pl1.id order by ps1.id) as row_num1, max(heure_chanson) as heure_derniere_chanson1, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson1, s1.title as title1, s1.artist artist1, s1.filename filename1
 from playlists pl1 left join playlistsongs ps1 on ps1.playlist_id = pl1.id left join songs s1
on s1.id = ps1.song_id
union all
select 
 heure_chanson as heure_chanson1,filename as prev_filename, pl1.id as playlistid1,s1.created_at as s1created, s1.title as title_prec,s1.artist as artist_prec, s1.id as songid1, row_number() OVER(partition by pl1.id order by ps1.id) as row_num1, max(heure_chanson) as heure_derniere_chanson1, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson1, s1.title title1, s1.artist artist1, s1.filename filename1
 from playlists pl1 left join playlistrecordings ps1 on ps1.playlist_id = pl1.id left join recordings s1
on s1.id = ps1.recording_id


group by songid1, playlistid1,s1created

order by heure_chanson asc
)t2_prec on t2_prec.row_num1 = (t1.row_num - 1) and t2_prec.playlistid1 = t1.playlistid
left outer join (

select 
 heure_chanson as heure_chanson3,filename as suiv_filename, pl3.id as playlistid3,s3.created_at as s3created, s3.title as title_suiv,s3.artist as artist_suiv, s3.id as songid3, row_number() OVER(partition by pl3.id order by ps3.id) as row_num3, max(heure_chanson) as heure_derniere_chanson3, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson3, s3.title as title3, s3.artist artist3, s3.filename filename3
 from playlists pl3 left join playlistsongs ps3 on ps3.playlist_id = pl3.id left join songs s3
on s3.id = ps3.song_id
union all
select 
 heure_chanson as heure_chanson3,filename as suiv_filename, pl3.id as playlistid3,s3.created_at as s3created, s3.title as title_suiv,s3.artist as artist_suiv, s3.id as songid3, row_number() OVER(partition by pl3.id order by ps3.id) as row_num3, max(heure_chanson) as heure_derniere_chanson3, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson3, s3.title title3, s3.artist artist3, s3.filename filename3
 from playlists pl3 left join playlistrecordings ps3 on ps3.playlist_id = pl3.id left join recordings s3
on s3.id = ps3.recording_id

group by songid3, playlistid3,s3created

order by heure_chanson asc
) 
t3_suiv on t3_suiv.row_num3 = (t1.row_num +1) and t3_suiv.playlistid3 = t1.playlistid

group by songid, playlistid
having (cast(strftime('%s',heure_chanson) as float)+duree > ?)
order by heure_chanson asc

 
      ", DateTime.now.to_f]))
p @a[0]
  if @a[0]
      
      x= DateTime.now.to_f - (DateTime.parse(@a[0]["heure_chanson"]).to_f) 
      p x
      if x > 0 and @a.length > 0
        {song: @a[0].as_json, maduree: (x)}
      else
        {}
      end
    else
      {}
    end
  end  
end
