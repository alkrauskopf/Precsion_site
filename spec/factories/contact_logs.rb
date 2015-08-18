FactoryGirl.define do
  factory :contact_log do
    was_sent false
from_email "MyString"
workplace "MyString"
distribution "MyString"
message "MyText"
  end

end
