class PaymentNotifier < ApplicationMailer
  default from: 'Precision Prep Team<payment@precisionschoolimprovement.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  #

  def pay_confirm_user(payment)
      @name = payment.buyable.full_name
      @event = payment.buyable.event ? payment.buyable.event.name : 'Event Not Defined'
      @event_date = payment.buyable.event ? payment.buyable.event.start_date : nil
      @venue = (payment.buyable.event && payment.buyable.event.venue) ? payment.buyable.event.venue.name : 'Venue Not Defined'
      @email = payment.buyable.email
      @enrollment = payment.buyable.enrollment
      @amount = payment.amount
      @fee = payment.buyable.amount
      @enroll_status = payment.buyable.status.upcase
      mail to: @email
  end

  def pay_confirm_prec(payment)
    @name = payment.buyable.full_name
    @event = payment.buyable.event ? payment.buyable.event.name : 'Event Not Defined'
    @event_date = payment.buyable.event ? payment.buyable.event.start_date : nil
    @venue = (payment.buyable.event && payment.buyable.event.venue) ? payment.buyable.event.venue.name : 'Venue Not Defined'
    @email = payment.buyable.email
    @enrollment = payment.buyable.enrollment
    @fee = payment.buyable.amount
    @amount = payment.amount
    @status = payment.status
    @enroll_status = payment.buyable.status.upcase
    mail to: User.prep_notify_list
  end

  def pay_confirm_prec_but(payment)
    @name = payment.buyable.full_name
    @event = payment.buyable.event ? payment.buyable.event.name : 'Event Not Defined'
    @event_date = payment.buyable.event ? payment.buyable.event.start_date : nil
    @venue = (payment.buyable.event && payment.buyable.event.venue) ? payment.buyable.event.venue.name : 'Venue Not Defined'
    @email = payment.buyable.email
    @enrollment = payment.buyable.enrollment
    @fee = payment.buyable.amount
    @amount = payment.amount
    @status = payment.status
    @enroll_status = payment.buyable.status.upcase
    mail to: User.prep_notify_list
  end
end
