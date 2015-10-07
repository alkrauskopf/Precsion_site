class Admin::EscentsController < ApplicationController

  before_action :admin_authorize, :set_escent, only: [:edit, :show, :update, :destroy]

  def index
  @escents = Escent.by_position
  end

  def new
    @escent = Escent.new
  end

  def create
    @escent = Escent.new(escent_params)

    respond_to do |format|
      if @escent.save
        format.html { redirect_to admin_escents_path, notice: "#{@escent.name} has been created." }
        format.json { render :show, status: :ok, location: @escent }
      else
        format.html { render :new }
        format.json { render json: @escent.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end


  def update
    respond_to do |format|
      if @escent.update(escent_params)
        format.html { redirect_to admin_escent_path, notice: "#{@escent.name} has been updated." }
        format.json { render :show, status: :ok, location: @escent }
      else
        format.html { render :edit }
        format.json { render json: @escent.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

  end

  def destroy
    @escent.destroy
    respond_to do |format|
        format.html { redirect_to admin_escents_path, notice: 'Escent Link has been deleted.' }
        format.json { head :no_content }
    end
  end


  private

  def set_escent
    @escent = Escent.find(params[:id])
  end

  def escent_params
    params.require(:escent).permit(:name, :url, :position, :escent_type, :is_active)
  end

end

