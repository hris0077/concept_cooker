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
end
