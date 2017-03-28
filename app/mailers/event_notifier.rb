class EventNotifier < ApplicationMailer
  default from: 'Precision Prep<do_not_reply@precisionschoolimprovement.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  #

  def email_them(event, subject_line, message )
    @event = event
    @message = message
    mail(:to => event.enrollment_distribution_list, :subject => subject_line, :bcc => User.prep_notify_list)
  end

end
