# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  country    :string
#  city       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Address < ApplicationRecord
end
