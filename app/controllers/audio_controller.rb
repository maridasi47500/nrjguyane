require "date"
class AudioController < ApplicationController
  protect_from_forgery except:[:save]
  def save
    @playlist=Playlist.find(params[:playlist_id])
    @emission=Emission.find(params[:emission_id])
    p params[:recording]
    @title=@emission.title
    if @emission.animateurs.length > 0
      @title << (" - " + @emission.animateurs.map(&:title).to_sentence)
    end
    @recording= Recording.new(myparams)
    @recording.title=@title
    if !@recording.save
      p @recording.errors
    end
    @heures=@playlist.playlistsongs.where("heure_chanson > ?",DateTime.now).pluck(:heure_chanson)

    @heure_chanson=@heures[0]||DateTime.now
    @prochaine_heure=@heure_chanson.to_f+@recording.duration.to_f

    Playlistrecording.create(emission_id: @emission.id, recording_id: @recording.id, playlist_id: @playlist.id,heure_chanson: @heure_chanson)
    #
    i=0
    (@playlist.playlistsongs.where("heure_chanson > ?",DateTime.now).to_a + @playlist.playlistrecordings.where("heure_chanson > ?",DateTime.now).to_a).sort_by{|h|h.heure_chanson}.each do |h|
      h.update(heure_chanson: Time.at(@prochaine_heure).to_datetime)
      begin
        p h.song
        @prochaine_heure+=h.song.duration.to_f
      rescue
        @prochaine_heure+=h.recording.duration.to_f
      end
      i+=1
    end
    render json:{"filename"=> @recording.filename}



    
  end
  private
  def myparams
    params.permit(:recording)
  end
end
