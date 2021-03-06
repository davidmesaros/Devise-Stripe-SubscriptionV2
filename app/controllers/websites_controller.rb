class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy]

  # GET /websites
  # GET /websites.json
  def index
    
    @websites = Website.all  if current_user.admin.blank?
    @websites = Website.paginate(page: params[:page], per_page: 8) if current_user.admin.present?

    renew_date # renew-date after 1 month...application control is the method block
    
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    
  end

  # GET /websites/new
  def new
    @website = Website.new(:user_id => current_user.id)
    @website.user = current_user
  end

  # GET /websites/1/edit
  def edit
    
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new(website_params)
    @website.user = current_user
    # Action Mailer Set up
    SwiftadsMailer.swiftads_email(@website.user, @website.name).deliver_now

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1
  # PATCH/PUT /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
    if current_user.admin.blank?
      SwiftadsMailer.swiftads_email_update(@website.user, @website.name, @website.product, @website.product1, @website.product2).deliver_now # this get email out when the cleint may have update there website details
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url, notice: 'Website was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = Website.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def website_params
      params.require(:website).permit(:name, :product, :product1, :product2, :user_id, :advertising)
    end
end
