FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:name) { |n| "FirstName#{n} LastName#{n}" }
    sequence(:username) { |n| "Username #{n}" }
    password { "123456" }
    password_confirmation { password }
  end
end
