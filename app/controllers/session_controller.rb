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
    contact_log = ContactLog.create(contact_us_params)
    contact_log.distribution = 'alkrauskopf@gmail.com, mlindimore@precisionschoolimprovement.com'
    if contact_log.save
      flash[:notice] = "Message Sent."
      contact_log.email_us!
    else
      flash[:error] = contact_log.errors.full_messages
    end
    redirect_to root_path
  end

  def destroy
    if user = current_user
      session.delete(:id)
      redirect_to root_path, notice: "#{user.full_name} has been logged out"
    end
  end

  private
  def contact_us_params
    params.require(:contact_log).permit(:user_email, :workplace, :message, :name)
  end
end
