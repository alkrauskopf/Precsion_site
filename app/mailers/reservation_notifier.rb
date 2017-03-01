class ReservationNotifier < ApplicationMailer
  default from: 'Precision Prep Team<enrollment@precisionschoolimprovement.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  #

  def notify_us(reservation)
    @name = reservation.full_name
    @email = reservation.email
    @phone = reservation.phone
    @enrollment = reservation
    @fee = reservation.price
    mail to: reservation.notification_list
  end

  def confirmation(reservation)
    @name = reservation.full_name
    @email = reservation.email
    @fee = reservation.price
    @enrollment = reservation
    mail to: @email
  end
end
