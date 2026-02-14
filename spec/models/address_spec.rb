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

require 'rails_helper'

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
