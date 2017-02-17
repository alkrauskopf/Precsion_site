class Admin::PrepController < ApplicationController

  before_action :admin_authorize, :set_venue, only: [:edit, :update, :destroy]
  before_action :banner_image, except: []

  def index
    @venues = Venue.all.by_name
    @venue = Venue.new
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      flash[:notice] = "#{@venue.name} Created"
    else
      flash[:error] = @venue.errors.full_messages
    end
    redirect_to admin_prep_path
  end

  def edit

  end

  def update
    if @venue.update(venue_params)
      flash[:notice] = 'Updated Venue'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to admin_prep_path
  end

  def destroy
    if (!@venue.nil? && @venue.destroy)
      flash[:notice] = 'Venue was successfully destroyed.'
    else
      flash[:error] = 'Venue Not Destroyed'
    end
    redirect_to admin_prep_path
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :notes, :is_active)
  end

end


