class Admin::UserClassesController < ApplicationController

  before_action :pm_offerings, except: []
  before_action :admin_authorize
  before_action :set_user_class, only: [:show, :edit, :update, :destroy]
  before_action :banner_image, except: []

  # GET /user_classes
  # GET /user_classes.json
  def index
    @user_classes = UserClass.all
  end

  # GET /user_classes/1
  # GET /user_classes/1.json
  def show
  end

  # GET /user_classes/new
  def new
    @user_class = UserClass.new
  end

  # GET /user_classes/1/edit
  def edit
  end

  # POST /user_classes
  # POST /user_classes.json
  def create
    @user_class = UserClass.new(user_class_params)

    respond_to do |format|
      if @user_class.save
        format.html { redirect_to @user_class, notice: 'User class was successfully created.' }
        format.json { render :show, status: :created, location: @user_class }
      else
        format.html { render :new }
        format.json { render json: @user_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_classes/1
  # PATCH/PUT /user_classes/1.json
  def update
    respond_to do |format|
      if @user_class.update(user_class_params)
        format.html { redirect_to @user_class, notice: 'User class was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_class }
      else
        format.html { render :edit }
        format.json { render json: @user_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_classes/1
  # DELETE /user_classes/1.json
  def destroy
    @user_class.destroy
    respond_to do |format|
      format.html { redirect_to user_classes_url, notice: 'User class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_class
      @user_class = UserClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_class_params
      params.require(:user_class).permit(:abbrev, :name, :description)
    end
end
