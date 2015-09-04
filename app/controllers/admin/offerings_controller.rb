class Admin::OfferingsController < ApplicationController

  before_action :admin_authorize, :set_offering, only: [:edit, :show, :update, :destroy]

  before_action :find_parent, only: [:show]

  def index
    @offerings = Offering.all
    @parent = Offering.find_parent(@offerings[0])
  end

  def new
    @offering = Offering.new
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
    if @offering.parent_id != nil
      find_parent
    end
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
    # show page for specific offering
  end

  def destroy
    @offering.destroy
    respond_to do |format|
        format.html { redirect_to admin_offerings_path, notice: 'Offering has been deleted.' }
        format.json { head :no_content }
    end
  end

  private

  def set_offering
    @offering = Offering.find(params[:id])
  end

  def find_parent
    @parent = Offering.find_parent(@offering)
  end

  def offering_params
    params.require(:offering).permit(:name, :brief, :description,
      :display_position, :is_visible, :parent_id)
  end
end
