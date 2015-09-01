class Admin::OfferingsController < ApplicationController

  before_action :admin_authorize, :set_offering, only: [:edit, :show, :update, :destroy]

  def index
    @offerings = Offering.all
  end

  def new
    @offering = Offering.new
  end

  def create
    respond_to do |format|
      if @offering.save
        format.html { redirect_to admin_offering_path, notice: "#{@offering.name} has been created." }
        format.json { render :show, status: :ok, location: @offering }
      else
        format.html { render :new }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
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

  def offering_params
    params.require(:offering).permit(:name, :brief, :description, :position, :visible)
  end
end
