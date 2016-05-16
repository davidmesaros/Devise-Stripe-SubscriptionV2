class AdvertisesController < ApplicationController
  before_action :set_advertise, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:show]
  # GET /advertises
  # GET /advertises.json
  def index
    @advertises = Advertise.all
    
  end

  # GET /advertises/1
  # GET /advertises/1.json
  def show
    
  end

  # GET /advertises/new
  def new
    @website = params[:website_id]
    @advertise = Advertise.new(:website_id => @website)
    

  end

  # GET /advertises/1/edit
  def edit
  end

  # POST /advertises
  # POST /advertises.json
  def create
    @advertise = Advertise.new(advertise_params)

    respond_to do |format|
      if @advertise.save
        format.html { redirect_to @advertise, notice: 'Advertise was successfully created.' }
        format.json { render :show, status: :created, location: @advertise }
      else
        format.html { render :new }
        format.json { render json: @advertise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advertises/1
  # PATCH/PUT /advertises/1.json
  def update
    respond_to do |format|
      if @advertise.update(advertise_params)
        format.html { redirect_to @advertise, notice: 'Advertise was successfully updated.' }
        format.json { render :show, status: :ok, location: @advertise }
      else
        format.html { render :edit }
        format.json { render json: @advertise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertises/1
  # DELETE /advertises/1.json
  def destroy
    @advertise.destroy
    respond_to do |format|
      format.html { redirect_to advertises_url, notice: 'Advertise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertise
      @advertise = Advertise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertise_params
      params.require(:advertise).permit(:description, :website_id)
    end

    def require_admin
      if logged_in? && !current_user.admin.present?
      flash[:danger] = "Only Admin's have Access"
      redirect_to root_path
      end      
    end
end
