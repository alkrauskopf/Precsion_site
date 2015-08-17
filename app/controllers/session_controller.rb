class SessionController < ApplicationController

  def login
    # GET action for the login page
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      # user provides valid auth creds
      session[:id] = user.id
      redirect_to root_path, notice: "Welcome back #{user.first_name}"
    else
      flash[:error] = 'Incorrect email or password'
      render :login
    end
  end

  def contact_us
    email = params[:email]
    message = params[:message]
    workplace = params[:workplace]
    redirect_to root_path, notice: "Email Sent from: #{email}. Workplace: #{workplace}. Message: #{message}"
  end

  def destroy
    if user = current_user
      session.delete(:id)
      redirect_to root_path, notice: "#{user.full_name} has been logged out"
    end
  end
end
