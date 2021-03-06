class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:edit, :update, :destroy]
  before_action :require_user_same, only: [:edit, :update, :destroy]
  before_action :require_same_dashbaord_id, only: [:show]
  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all
    @dashboards = Dashboard.paginate(page: params[:page], per_page: 8) if current_user.admin.present?
    
    # From Website index to DashBoard
    # instance to index to valid? a new link 
    # @website_new = params[:website]
    # this needs to be the last line as it is double instance to carry below to next method
    # @@website = params[:website]
    
    destroy_data # destroy data after 1 month...data_dashboards...
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @dashboard = Dashboard.find_by(:website_id => params[:id]) || Dashboard.find(params[:id])# this show gets the params when there is not ID ( websites/index => dashbaord_new)
    # @dashboard = Dashboard.find(params[:id]) if params[:id].blank? # gets ID when the params is created with an ID
    find_params_for_data_dashboard # calls @dashboard params to Application
  
  end

  # GET /dashboards/new
  def new
    @website_new = params[:website]# this params is a hack from Websites Index
    @dashboard = Dashboard.new(:website_id => @website_new) #@@website -> index, - not taking via index approch

  end

  # GET /dashboards/1/edit
  def edit


  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end

      dashboard_data # this from the help controller -> DataDashboard.new => when Dashboard created
      @website = Website.find(@dashboard.website_id)
      # SwiftadsMailer.dashboard_update(@website.user, @website.name).deliver_now # when dashboard created
      mailer_array
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update

    respond_to do |format|
      if @dashboard.update(dashboard_params )
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end

      dashboard_data # this from the help controller -> DataDashboard.new => collected the update value and create a new Data
      #
      mailer_array # application controll => limits the number Dashboard Update
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params.require(:dashboard).permit(:calls, :clicks, :searches, :cost, :budget, :smartphones, :tablets, :computers, :website_id)
    end

    def require_user_same # extra security for users
      if current_user != @user && !current_user.admin?
        flash[:danger] = "This Page is not Accessible"
        redirect_to root_path
      end
    end


    def require_same_dashbaord_id # from the show in Dashboard Controller
      if current_user.admin.blank?
        website_id_array = []
        params_id = []
        current_user.websites.each do |website|
            id_website = params[:id].to_i if params[:id].to_i == website.id
            dash_id = Website.find(id_website) if id_website.present?
          
              website_id_array << dash_id.id if id_website.present?#dash_id.id == params[:id].to_i and
              params_id << params[:id].to_i
          
         end 
          
          if website_id_array[0] == nil #|| params_id[0] != website_id_array[0]  #and params[:id].to_i != website.id
               
                flash[:danger] = "The Page you Attempted is not Accessible"
                redirect_to root_path 
                return
          
                
          end
        end
      
    end

    


end
