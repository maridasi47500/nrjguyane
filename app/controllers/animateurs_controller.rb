class AnimateursController < ApplicationController
  before_action :set_animateur, only: %i[ show edit update destroy ]

  # GET /animateurs or /animateurs.json
  def index
    @animateurs = Animateur.all.page params[:page]
  end

  # GET /animateurs/1 or /animateurs/1.json
  def show
  end

  # GET /animateurs/new
  def new
    @animateur = Animateur.new
  end

  # GET /animateurs/1/edit
  def edit
  end

  # POST /animateurs or /animateurs.json
  def create
    @animateur = Animateur.new(animateur_params)

    respond_to do |format|
      if @animateur.save
        format.html { redirect_to animateur_url(@animateur), notice: "Animateur was successfully created." }
        format.json { render :show, status: :created, location: @animateur }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @animateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animateurs/1 or /animateurs/1.json
  def update
    respond_to do |format|
      if @animateur.update(animateur_params)
        format.html { redirect_to animateur_url(@animateur), notice: "Animateur was successfully updated." }
        format.json { render :show, status: :ok, location: @animateur }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @animateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animateurs/1 or /animateurs/1.json
  def destroy
    @animateur.destroy

    respond_to do |format|
      format.html { redirect_to animateurs_url, notice: "Animateur was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animateur
      @animateur = Animateur.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animateur_params
      params.require(:animateur).permit(:title,:subtitle, :image, :description,:job)
    end
end
