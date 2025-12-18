require 'rails_helper'

RSpec.describe "addresses/edit", type: :view do
  let(:address) {
    Address.create!(
      country: "MyString",
      city: "MyString"
    )
  }

  before(:each) do
    assign(:address, address)
  end

  it "renders the edit address form" do
    render

    assert_select "form[action=?][method=?]", address_path(address), "post" do
      assert_select "input[name=?]", "address[country]"

      assert_select "input[name=?]", "address[city]"
    end
  end
end
