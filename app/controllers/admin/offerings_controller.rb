class Admin::OfferingsController < ApplicationController

  before_action :admin_authorize, :set_offering, only: [:edit, :show, :update, :destroy, :assign_pov]

  def index
    @offerings = Offering.arrange_by_position
    @parents = @offerings.select { |o| o.parent_id.nil? }
    # below creates a hash of :id/:name key/value pairs to be used in the view
    @parents_hash = @offerings.map { |offering| [offering.id, offering.name]}.to_h
  end

  def new
    @offering = Offering.new
    parent_options
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

  def edit
    parent_options
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

  def assign_pov

    respond_to do |format|
      format.html { redirect_to edit_admin_offering_path }
      format.json { head :no_content }
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
      :display_position, :is_visible, :parent_id)
  end

  def set_pov
    @pov = UserPov.find(params[:pov][:id])
  end
end
