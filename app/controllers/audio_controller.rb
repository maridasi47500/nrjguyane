class AudioController < ApplicationController
  protect_from_forgery except:[:save]
  def save
    @playlist=Playlist.find(params[:playlist_id])
    @emission=Emission.find(params[:emission_id])
    p params[:recording]
    @recording= Recording.new(myparams)
    @recording.save
    #@heures=@playlist.playlistsongs.where("heure_chanson > ?",DateTime.now).pluck(:heure_chanson)

    #@heure_chanson=@heures[0]||DateTime.now
    #@prochaine_heure=@heure_chanson.to_i+@recording.duration

    #Playlistrecording.create(emission_id: @emission.id, recording_id: @recording.id, playlist_id: @playlist.id,heure_chanson: @heure_chanson)
    ##
    #@playlist.playlistsongs.where("heure_chanson > ?",DateTime.now).each_with_index do |h,i|
    #  h.update(heure_chanson: @prochaine_heure.to_datetime)
    #  @prochaine_heure+=h.duration
    #end
    render json:{"filename"=> @recording.filename}



    
  end
  private
  def myparams
    params.permit(:recording)
  end
end
