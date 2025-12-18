require 'rails_helper'

RSpec.describe "addresses/index", type: :view do
  before(:each) do
    assign(:addresses, [
      Address.create!(
        country: "Country",
        city: "City"
      ),
      Address.create!(
        country: "Country",
        city: "City"
      )
    ])
  end

  it "renders a list of addresses" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Country".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("City".to_s), count: 2
  end
end
