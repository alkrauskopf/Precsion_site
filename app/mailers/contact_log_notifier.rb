class ContactLogNotifier < ApplicationMailer
  default from: 'Precision Team<contact_us@precisionschoolimprovement.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  #

  def contact_us(contact_log)
    @name = contact_log.name
    @message = contact_log.message
    @workplace = contact_log.workplace
    @email = contact_log.user_email
    mail to: contact_log.distribution
  end

  def contact_us_reply(contact_log)
    @name = contact_log.name
    @message = contact_log.message
    @workplace = contact_log.workplace
    @email = contact_log.user_email
    mail to: @email
  end
end
