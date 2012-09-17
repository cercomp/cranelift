FactoryGirl.define do
  factory :user do
    sequence(:login) { |count| "user_#{count}" }
    sequence(:email) { |count| "email_#{count}@domain.com" }
    password 'hadouken'
    ip_block false
    name 'User Batuta'
    active false
    login_type 'system'
  end
end
