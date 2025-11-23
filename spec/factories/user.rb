FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:username) { |n| "Username #{n}" }
    password { 123456 }
  end
end
