class DataDashboardsController < ApplicationController
  before_action :set_data_dashboard, only: [:show, :edit, :update, :destroy]

  # GET /data_dashboards
  # GET /data_dashboards.json
  def index
    @data_dashboards = DataDashboard.paginate(page: params[:page], per_page: 5) if current_user.admin.present?
    @data_dashboards = DataDashboard.where(created_at: 8.days.ago..Time.now) if current_user.admin.blank?

    destroy_data # destroy data after 1 month...

    total_dashboards # the method is called in the application => cal the total and average 
    
    dashboard_data_finder## the method is called in the application 
    
   
    # bal_bugdet # working to find bal left over from the budget.
    
  end

  # GET /data_dashboards/1
  # GET /data_dashboards/1.json
  def show
  end

  # GET /data_dashboards/new
  def new
    @data_dashboard = DataDashboard.new
  end

  # GET /data_dashboards/1/edit
  def edit
  end

  # POST /data_dashboards
  # POST /data_dashboards.json
  def create
    @data_dashboard = DataDashboard.new(data_dashboard_params)

    respond_to do |format|
      if @data_dashboard.save
        format.html { redirect_to @data_dashboard, notice: 'Data dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @data_dashboard }
      else
        format.html { render :new }
        format.json { render json: @data_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_dashboards/1
  # PATCH/PUT /data_dashboards/1.json
  def update
  
    respond_to do |format|
      if @data_dashboard.update(data_dashboard_params)
        format.html { redirect_to @data_dashboard, notice: 'Data dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @data_dashboard }
      else
        format.html { render :edit }
        format.json { render json: @data_dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_dashboards/1
  # DELETE /data_dashboards/1.json
  def destroy
    @data_dashboard.destroy
    respond_to do |format|
      format.html { redirect_to data_dashboards_url, notice: 'Data dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_dashboard
      @data_dashboard = DataDashboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_dashboard_params
      params.require(:data_dashboard).permit(:calls, :clicks, :searches, :cost, :budget, :smartphones, :tablets, :computers, :dashboard_id)
    end
end
