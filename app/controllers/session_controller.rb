class SessionController < ApplicationController
  before_action :banner_image, except: []
  before_action :event_email_params, only: [:event_email_them]

  def login
    # GET action for the login page
    @login = true
  end

  def create
  user = User.find_by_email(params[:email])
  #  user = User.all.first
    if user && user.active? && user.authenticate(params[:password])
      # user provides valid auth creds
      session[:id] = user.id
      redirect_to root_path, notice: "Welcome back #{user.first_name}"
    else
      flash[:error] = 'Incorrect email or password'
      render :login
    end
  end

  def contact_us
    used_captcha
    if @captcha_pass
      if contact_us_filtered?
        contact_log = ContactLog.create(contact_us_params)
        contact_log.distribution = User.contact_list
        if contact_log.save
          flash[:notice] = "Message Sent."
          contact_log.email_us!
        else
          flash[:error] = contact_log.errors.full_messages
        end
      else
        flash[:error] = "Please Contact Us without including a link in your Message, Name, or Workplace.  Thank You."
      end
    else
      flash[:error] = "Sorry. You Did Not Correctly Identify The Picture. Please Try Again."
    end
    redirect_to root_path
  end

  def event_email_them
    if !@event.nil?
      if !@subject_line.empty? && !@message.empty?
        EventNotifier.email_them(@event, @subject_line, @message).deliver_now
      else
        flash[:error] = "Empty Subject Line or Message."
      end
    else
      flash[:error] = "Event Not Found."
    end
    redirect_to root_path
  end

  def image_show
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

  def event_email_params
    @event = Event.find_by_id(params[:event_id]) rescue nil
    @subject_line = params[:event_email][:subject]
    @message = params[:event_email][:message]
  end

  def contact_us_filtered?
    filtered = true
    if (contact_us_params[:message] =~ /\bhttp?:/) || (contact_us_params[:name] =~ /\bhttp?:/) || (contact_us_params[:workplace] =~ /\bhttp?:/)
      filtered = false
    end
    filtered
  end

  def used_captcha
    @captcha = CaptchaImage.find_by_id(params[:contact_log][:captcha_id]) rescue nil
    @captcha_guess = params[:captcha_guess]
    @captcha_pass = (!@captcha.nil? && @captcha_guess.upcase.include?(@captcha.name.upcase)) || @captcha.nil?
  end
end
