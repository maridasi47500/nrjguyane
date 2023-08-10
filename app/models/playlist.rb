class Playlist < ApplicationRecord
  after_update :poiuytre
  after_create :poiuytre
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
    playlists.*, ps.heure_chanson, songs.duree,strftime('%H:%M:%S','now')  as now,songs.created_at as songscreatedat,cast(strftime('%s','now') as float) - cast(strftime('%s',ps.heure_chanson) as float) as moment_dans_chanson,cast(strftime('%s',ps.heure_chanson) as float) as debut_chanson,cast(strftime('%s',ps.heure_chanson) as float) + songs.duree as madureetotale, playlists.id as playlistid,cast(strftime('%s','now') as float) as timenow, songs.id as songid, row_number() OVER(partition by playlists.id,playlists.created_at order by ps.id) as row_num, max(heure_chanson) as heure_derniere_chanson, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson, songs.title, songs.artist, songs.filename, null as recording_id, null as emission_id, ps.song_id, ps.id as psid, 'song' as mytype
    from playlists
    left join playlistsongs ps on ps.playlist_id = playlists.id and cast(strftime('%s',ps.heure_chanson) as float) < cast(strftime('%s','now') as float) left join songs on        songs.id = ps.song_id and cast(strftime('%s',ps.heure_chanson) as float)+songs.duree > cast(strftime('%s','now') as float)
    union
    select playlistsA.*, psA.heure_chanson, songsA.duree,strftime('%H:%M:%S','now')  as now,songsA.created_at as songscreatedat,cast(strftime('%s','now') as float) - cast(strftime('%s',psA.heure_chanson) as float) as moment_dans_chanson,cast(strftime('%s',psA.heure_chanson) as float) as debut_chanson,cast(strftime('%s',psA.heure_chanson) as float) + songsA.duree as madureetotale, playlistsA.id as playlistid,cast(strftime('%s','now') as float) as timenow, songsA.id as songid, row_number() OVER(partition by playlistsA.id,playlistsA.created_at order by psA.id) as row_num, max(heure_chanson) as heure_derniere_chanson, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson, songsA.title, songsA.artist, songsA.filename, psA.recording_id, psA.emission_id, null as song_id, psA.id as psid, 'recording' as mytype
    from playlists playlistsA
     left join playlistrecordings psA on psA.playlist_id = playlistsA.id and cast(strftime('%s',psA.heure_chanson) as float) < cast(strftime('%s','now') as float) left join recordings songsA on        songsA.id = psA.recording_id
       and cast(strftime('%s',psA.heure_chanson) as float)+songsA.duree > cast(strftime('%s','now') as float)

        group by songid, playlistid, mytype

         order by heure_chanson asc

) t1 
left outer join (

select 
 heure_chanson as heure_chanson1,filename as prev_filename, pl1.id as playlistid1,s1.created_at as s1created, s1.title as title_prec,s1.artist as artist_prec, s1.id as songid1, row_number() OVER(partition by pl1.id,pl1.created_at order by ps1.id) as row_num1, max(heure_chanson) as heure_derniere_chanson1, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson1, s1.title as title1, s1.artist artist1, s1.filename filename1, null as emission_id, null as recording_id, song_id
 from playlists pl1 
    left join playlistsongs ps1 on ps1.playlist_id = pl1.id and cast(strftime('%s',ps1.heure_chanson) as float) < cast(strftime('%s','now') as float) left join songs s1 on        s1.id = ps1.song_id and cast(strftime('%s',ps1.heure_chanson) as float)+s1.duree > cast(strftime('%s','now') as float)
union
select 
 heure_chanson as heure_chanson1,filename as prev_filename, pl1A.id as playlistid1,s1A.created_at as s1created, s1A.title as title_prec,s1A.artist as artist_prec, s1A.id as songid1, row_number() OVER(partition by pl1A.id,pl1A.created_at order by ps1A.id) as row_num1, max(heure_chanson) as heure_derniere_chanson1, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson1, s1A.title title1, s1A.artist artist1, s1A.filename filename1, ps1A.emission_id, ps1A.recording_id, null as song_id
 from playlists pl1A 
    left join playlistrecordings ps1A on ps1A.playlist_id = pl1A.id and cast(strftime('%s',ps1A.heure_chanson) as float) < cast(strftime('%s','now') as float) left join recordings s1A on        s1A.id = ps1A.recording_id and cast(strftime('%s',ps1A.heure_chanson) as float)+s1A.duree <= cast(strftime('%s','now') as float)


group by songid1

order by heure_chanson asc
)t2_prec on t2_prec.heure_chanson1 < t1.heure_chanson
left outer join (

select 
 heure_chanson as heure_chanson3,filename as suiv_filename, pl3.id as playlistid3,s3.created_at as s3created, s3.title as title_suiv,s3.artist as artist_suiv, s3.id as songid3, row_number() OVER(partition by pl3.id,pl3.created_at order by ps3.id) as row_num3, max(heure_chanson) as heure_derniere_chanson3, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson3, s3.title as title3, s3.artist artist3, s3.filename filename3, null as recording_id, null as emission_id, ps3.song_id
 from playlists pl3 
    left join playlistsongs ps3 on ps3.playlist_id = pl3.id and cast(strftime('%s',ps3.heure_chanson) as float) > cast(strftime('%s','now') as float) left join songs s3 on        s3.id = ps3.song_id and cast(strftime('%s',ps3.heure_chanson) as float)+s3.duree > cast(strftime('%s','now') as float)
union
select 
 heure_chanson as heure_chanson3,filename as suiv_filename, pl3A.id as playlistid3,s3A.created_at as s3created, s3A.title as title_suiv,s3A.artist as artist_suiv, s3A.id as songid3, row_number() OVER(partition by pl3A.id,pl3A.created_at order by ps3A.id) as row_num3, max(heure_chanson) as heure_derniere_chanson3, (case when max(heure_chanson) = heure_chanson then duree else 0 end) as duree_derniere_chanson3, s3A.title title3, s3A.artist artist3, s3A.filename filename3, null as song_id, ps3A.emission_id, ps3A.recording_id
 from playlists pl3A 
    left join playlistrecordings ps3A on ps3A.playlist_id = pl3A.id and cast(strftime('%s',ps3A.heure_chanson) as float) < cast(strftime('%s','now') as float) left join recordings s3A on        s3A.id = ps3A.recording_id and cast(strftime('%s',ps3A.heure_chanson) as float)+s3A.duree > cast(strftime('%s','now') as float)

group by songid3

order by heure_chanson asc
) 
t3_suiv on t3_suiv.heure_chanson3 > t1.heure_chanson

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
