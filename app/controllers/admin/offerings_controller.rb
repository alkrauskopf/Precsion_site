class Admin::OfferingsController < ApplicationController

  before_action :pm_offerings, except: []
  before_action :admin_authorize
  before_action :set_offering, only: [:edit, :show, :update, :destroy, :assign_pov, :assign_testimony]
  before_action :set_image, only: [:edit_image, :update_image, :destroy_image]
  before_action :set_content, only: [:edit_content, :update_content, :destroy_content, :create_content]
  before_action :set_stat, only: [:edit_stat, :update_stat, :destroy_stat]
  before_action :banner_image, except: []

  def index
    @parents = Offering.all_parents.sort_by{|p| p.type_name}
  end

  def new
    @offering = Offering.new
    parent_options
  end

  def new_image
    @offering_image = OfferingImage.new
    @offering = Offering.find(params[:offering_id])
  end

  def new_content
    @content = Content.new
    @offering = Offering.find(params[:offering_id])
  end

  def new_stat
    @stat = Stat.new
    @offering = Offering.find(params[:offering_id])
  end

  def create
    @offering = Offering.new(offering_params)
    respond_to do |format|
      if @offering.save
        format.html { redirect_to admin_offering_path(@offering.id), notice: "#{@offering.name} has been created." }
        format.json { render :show, status: :ok, location: @offering }
      else
        parent_options
        format.html { render :new }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_image
    @offering_image = OfferingImage.new(image_params)

    respond_to do |format|
      if @offering_image.save
        format.html { redirect_to edit_admin_offering_path(@offering_image.offering), notice: "#{@offering_image.name} has been created." }
        format.json { render :show, status: :ok, location: @offering_image }
      else
        format.html { render :new_image }
        format.json { render json: @offering_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_content
    @content = Content.new(content_params)
    @content.title = params[:content][:title]
    if @content.save
      redirect_to edit_admin_offering_path(@content.offering), notice: "#{@content.title} has been created."
    else
      flash[:error] = @content.errors.full_messages
      redirect_to edit_admin_offering_path(@offering)
    end
  end

  def create_stat
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to edit_admin_offering_path(@stat.offering), notice: "#{@stat.name} has been created." }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :new_stat }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    parent_options
  end

  def edit_image
  end

  def edit_content
  end

  def edit_stat
  end

  def update
    respond_to do |format|
      @offering.expire_date = expire_days_params[:num_days] == '' ? 10000.days.from_now : (Date.today + expire_days_params[:num_days].to_i)
      if @offering.update(offering_params)
        format.html { redirect_to admin_offering_path, notice: "#{@offering.name} has been updated." }
        format.json { render :show, status: :ok, location: @offering }
      else
        parent_options
        format.html { render :edit }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_image
    respond_to do |format|
      if @offering_image.update(image_params)
        format.html { redirect_to edit_admin_offering_path(@offering_image.offering), notice: "#{@offering_image.name} has been updated." }
        format.json { render :show, status: :ok, location: @offering_image }
      else
        format.html { render :edit }
        format.json { render json: @offering_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_content
    @offering = Offering.find(params[:content][:offering_id])
    @content.title = params[:content][:title]
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to edit_admin_offering_path(@content.offering), notice: "#{@content.title} has been updated." }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit_content }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_stat
    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to edit_admin_offering_path(@stat.offering), notice: "#{@stat.name} has been updated." }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :edit }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @parent = !@offering.parent_id.nil? ? @offering.parent : nil
  end

  def destroy
    @offering.destroy
    respond_to do |format|
        format.html { redirect_to admin_offerings_path, notice: 'Offering has been deleted.' }
        format.json { head :no_content }
    end
  end

  def destroy_image
    @offering = @offering_image.offering
    @offering_image.destroy
    respond_to do |format|
      format.html { redirect_to edit_admin_offering_path(@offering), notice: 'Image has been deleted.' }
      format.json { head :no_content }
    end
  end

  def destroy_content
    @offering = @content.offering
    @content.destroy
    respond_to do |format|
      format.html { redirect_to edit_admin_offering_path(@offering), notice: 'Content has been deleted.' }
      format.json { head :no_content }
    end
  end

  def destroy_stat
    @offering = @stat.offering
    @stat.destroy
    respond_to do |format|
      format.html { redirect_to edit_admin_offering_path(@offering), notice: 'Stat has been deleted.' }
      format.json { head :no_content }
    end
  end

  def assign_pov
    pov = UserPov.find(params[:pov_id])
    @offering.add_remove_pov!(pov)
    respond_to do |format|
      format.html { redirect_to edit_admin_offering_path(@offering)}
      format.js
    end
  end

  def assign_testimony
    tst = Offering.find(params[:testimony_id])
    @offering.add_remove_testimony!(tst)
    respond_to do |format|
      format.html { redirect_to edit_admin_offering_path(@offering)}
      format.js
    end
  end

  private

  def set_offering
    @offering = Offering.find(params[:id]) rescue nil
  end

  def parent_options
    # method populates the form drop-down menu
    @parent_array = Offering.all.map { |offering| [offering.name, offering.id]}
    @parent_array.unshift(['none', nil])
  end

  def offering_params
    params.require(:offering).permit(:name, :search_name, :brief, :description,
      :display_position, :is_visible, :is_default, :parent_id, :offering_type,
      :panel_header, :panel_color, :tst_person_name, :tst_person_role,
      :tst_statement, :tst_view_label, :tst_video, :tst_topic, :tst_organization)
  end

  def expire_days_params
    params.require(:expire).permit(:num_days)
  end


  def set_pov
    @pov = UserPov.find(params[:pov][:id])
  end

  def set_image
    if params[:id]
      @offering_image = OfferingImage.find(params[:id])
    end
  end

  def set_content
    if params[:id]
      @content = Content.find(params[:id])
    end
    if params[:content]
      @offering = Offering.find(params[:content][:offering_id]) rescue nil
    end
  end

  def set_stat
    if params[:id]
      @stat = Stat.find(params[:id])
    end
  end


  def image_params
    params.require(:offering_image).permit(:name, :url, :is_carousel_img,
                                           :display_position, :is_active, :is_head, :is_header,
                                           :is_button, :offering_id, :description, :image)
  end

  def content_params
    params.require(:content).permit(:content_url, :description, :position, :is_active, :content_type, :offering_id, :attached_report)
  end


  def stat_params
    params.require(:stat).permit(:name, :stat,
                                    :position, :is_active,
                                    :offering_id)
  end
end

# Trivial change -- delete me
