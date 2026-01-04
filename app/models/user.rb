# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  username   :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :name, :username, presence: true
  validates :password, length: { in: 6..20 }
  validates :password, confirmation: true, unless: -> { password.blank? }
  validates :password_confirmation, presence: true, on: :create
end
