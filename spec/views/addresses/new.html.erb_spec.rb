require 'rails_helper'

RSpec.describe "addresses/new", type: :view do
  before(:each) do
    assign(:address, Address.new(
      country: "MyString",
      city: "MyString"
    ))
  end

  it "renders new address form" do
    render

    assert_select "form[action=?][method=?]", addresses_path, "post" do
      assert_select "input[name=?]", "address[country]"

      assert_select "input[name=?]", "address[city]"
    end
  end
end
