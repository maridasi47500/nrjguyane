class CinemasController < ApplicationController
  before_action :set_cinema, only: %i[ show edit update destroy ]

  # GET /cinemas or /cinemas.json
  def index
    @cinemas = Cinema.all
  end

  # GET /cinemas/1 or /cinemas/1.json
  def show
  end

  # GET /cinemas/new
  def new
    @cinema = Cinema.new
  end

  # GET /cinemas/1/edit
  def edit
  end

  # POST /cinemas or /cinemas.json
  def create
    @cinema = Cinema.new(cinema_params)

    respond_to do |format|
      if @cinema.save
        format.html { redirect_to cinema_url(@cinema), notice: "Cinema was successfully created." }
        format.json { render :show, status: :created, location: @cinema }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cinema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cinemas/1 or /cinemas/1.json
  def update
    respond_to do |format|
      if @cinema.update(cinema_params)
        format.html { redirect_to cinema_url(@cinema), notice: "Cinema was successfully updated." }
        format.json { render :show, status: :ok, location: @cinema }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cinema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cinemas/1 or /cinemas/1.json
  def destroy
    @cinema.destroy

    respond_to do |format|
      format.html { redirect_to cinemas_url, notice: "Cinema was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cinema
      @cinema = Cinema.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cinema_params
      params.require(:cinema).permit(:title, :image, :description, :subtitle)
    end
end
