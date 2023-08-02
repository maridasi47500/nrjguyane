class VideoplaylistsController < ApplicationController
  before_action :set_videoplaylist, only: %i[ show edit update destroy ]

  # GET /videoplaylists or /videoplaylists.json
  def index
    @videoplaylists = Videoplaylist.all
  end

  # GET /videoplaylists/1 or /videoplaylists/1.json
  def show
  end

  # GET /videoplaylists/new
  def new
    @videoplaylist = Videoplaylist.new
  end

  # GET /videoplaylists/1/edit
  def edit
  end

  # POST /videoplaylists or /videoplaylists.json
  def create
    @videoplaylist = Videoplaylist.new(videoplaylist_params)

    respond_to do |format|
      if @videoplaylist.save
        format.html { redirect_to videoplaylist_url(@videoplaylist), notice: "Videoplaylist was successfully created." }
        format.json { render :show, status: :created, location: @videoplaylist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @videoplaylist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videoplaylists/1 or /videoplaylists/1.json
  def update
    respond_to do |format|
      if @videoplaylist.update(videoplaylist_params)
        format.html { redirect_to videoplaylist_url(@videoplaylist), notice: "Videoplaylist was successfully updated." }
        format.json { render :show, status: :ok, location: @videoplaylist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @videoplaylist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videoplaylists/1 or /videoplaylists/1.json
  def destroy
    @videoplaylist.destroy

    respond_to do |format|
      format.html { redirect_to videoplaylists_url, notice: "Videoplaylist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_videoplaylist
      @videoplaylist = Videoplaylist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def videoplaylist_params
      params.fetch(:videoplaylist, {})
    end
end
