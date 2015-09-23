class Admin::OfferingsController < ApplicationController

  before_action :admin_authorize, :set_offering, only: [:edit, :show, :update, :destroy, :assign_pov]
  before_action :admin_authorize, :set_image, only: [:edit_image, :update_image, :destroy_image]

  def index
    @offerings = Offering.by_type.arrange_by_position
    @parents = @offerings.select { |o| o.parent_id.nil? }
    # below creates a hash of :id/:name key/value pairs to be used in the view
    @parents_hash = @offerings.map { |offering| [offering.id, offering.name]}.to_h
  end

  def new
    @offering = Offering.new
    parent_options
  end

  def new_image
    @offering_image = OfferingImage.new
    @offering = Offering.find(params[:offering_id])
  end

  def create
    @offering = Offering.new(offering_params)

    respond_to do |format|
      if @offering.save
        format.html { redirect_to admin_offering_path(@offering.id), notice: "#{@offering.name} has been created." }
        format.json { render :show, status: :ok, location: @offering }
      else
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
        format.html { render :new }
        format.json { render json: @offering_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    parent_options
  end


  def edit_image
  end

  def update
    respond_to do |format|
      if @offering.update(offering_params)
        format.html { redirect_to admin_offering_path, notice: "#{@offering.name} has been updated." }
        format.json { render :show, status: :ok, location: @offering }
      else
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

  def show
    @parent = @offering.parent
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


  def assign_pov
    pov = UserPov.find(params[:pov_id])
    @offering.add_remove_pov!(pov)
    respond_to do |format|
      format.html { redirect_to edit_admin_offering_path(@offering)}
      format.js
    end

  end

  private

  def set_offering
    @offering = Offering.find(params[:id])
  end

  def parent_options
    # method populates the form drop-down menu
    @parent_array = Offering.all.map { |offering| [offering.name, offering.id]}
    @parent_array.unshift(['none', nil])
  end

  def offering_params
    params.require(:offering).permit(:name, :brief, :description,
      :display_position, :is_visible, :parent_id, :offering_type)
  end

  def set_pov
    @pov = UserPov.find(params[:pov][:id])
  end

  def set_image
    if params[:id]
      @offering_image = OfferingImage.find(params[:id])
    end
  end

  def image_params
    params.require(:offering_image).permit(:name, :url, :is_carousel_img,
                                           :display_position, :is_active,
                                           :offering_id, :image)
  end

end

# Trivial change -- delete me
