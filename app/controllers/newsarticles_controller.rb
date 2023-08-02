class NewsarticlesController < ApplicationController
  before_action :set_newsarticle, only: %i[ show edit update destroy ]

  # GET /newsarticles or /newsarticles.json
  def index
    @newsarticles = Newsarticle.all.page params[:page]
  end

  # GET /newsarticles/1 or /newsarticles/1.json
  def show
  end

  # GET /newsarticles/new
  def new
    @newsarticle = Newsarticle.new(user_id: current_user.try(:id))
  end

  # GET /newsarticles/1/edit
  def edit
  end

  # POST /newsarticles or /newsarticles.json
  def create
    @newsarticle = Newsarticle.new(newsarticle_params)

    respond_to do |format|
      if @newsarticle.save
        format.html { redirect_to newsarticle_url(@newsarticle), notice: "Newsarticle was successfully created." }
        format.json { render :show, status: :created, location: @newsarticle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @newsarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsarticles/1 or /newsarticles/1.json
  def update
    respond_to do |format|
      if @newsarticle.update(newsarticle_params)
        format.html { redirect_to newsarticle_url(@newsarticle), notice: "Newsarticle was successfully updated." }
        format.json { render :show, status: :ok, location: @newsarticle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @newsarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsarticles/1 or /newsarticles/1.json
  def destroy
    @newsarticle.destroy

    respond_to do |format|
      format.html { redirect_to newsarticles_url, notice: "Newsarticle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsarticle
      @newsarticle = Newsarticle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def newsarticle_params
      params.require(:newsarticle).permit(:type, :title, :content, :image, :comphoto, :subtitle, :user_id)
    end
end
