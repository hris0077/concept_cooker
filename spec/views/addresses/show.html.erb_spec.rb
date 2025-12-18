require 'rails_helper'

RSpec.describe "addresses/show", type: :view do
  before(:each) do
    assign(:address, Address.create!(
      country: "Country",
      city: "City"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/City/)
  end
end
