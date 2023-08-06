class SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy returntime ]
  protect_from_forgery except: [:update]
  # GET /songs or /songs.json
  def index
    @songs = Song.all
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to song_url(@song), notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end
  def returntime
        respond_to do |format|

    format.js {render js: :returntime}
        end
  end
  def jouerunechanson
    @a=Playlist.myotherplaylist||{}
    respond_to do |format|
        format.json { render json: @a, status: :ok }
    end
  end
  # DELETE /songs/1 or /songs/1.json
  def musique
    respond_to do |format|
        format.json { render json: {ok: session[:playmusique], myvol: session[:myvol]}, status: :ok }
    end
  end
  def playmusique1
     session[:myvol] = params[:myvol].to_s
    respond_to do |format|
        format.json { render json: session[:playmusique], status: :ok }
    end
  end
  def playmusique
    session[:playmusique] = params[:play].to_s
    session[:myvol] = params[:myvol].to_s
    respond_to do |format|
        format.json { render json: session[:playmusique], status: :ok }
    end
  end
  
  def destroy
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :artist, :filename,:duree)
    end
end
