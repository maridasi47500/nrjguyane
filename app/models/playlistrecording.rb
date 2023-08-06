class Playlistrecording < ApplicationRecord
  belongs_to :recording
  belongs_to :playlist
  after_create :poiuytre
  def poiuytre
    x=self.playlist.playlistsongs.to_a+self.playlist.playlistrecordings.to_a
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

end
