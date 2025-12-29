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

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'can be saved to the database' do
    expect { user.save! }.not_to raise_error
  end
end
