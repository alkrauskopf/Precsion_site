class ContactLog < ActiveRecord::Base

  validates_format_of :user_email, :with => /\A[\w._%+-]+@[\w.-]+\.[\w]{2,6}\z/, :message => 'Your Email Has An Invalid Format. Please try again.',
                      :allow_nil => false
  validates_presence_of :name,  :message => 'Please Enter Your Name.  Try Again.'

  def sent?
    self.was_sent
  end

  def email_us!
    self.update(was_sent: true)
    ContactLogNotifier.contact_us(self).deliver_now
    ContactLogNotifier.contact_us_reply(self).deliver_now
  end

  def distribution_list
    User.contactees.join(', ')
  end

end
