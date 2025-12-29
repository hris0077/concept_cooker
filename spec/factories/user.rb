FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:username) { |n| "Username #{n}" }
    password { 123456 }
    password_confirmation { "123456" }
    name { "Admin John" }
  end
end
