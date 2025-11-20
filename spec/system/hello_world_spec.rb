require 'rails_helper'

RSpec.describe "HelloWorld", type: :system do
  it "visits the home page" do
    visit root_path
    expect(page).to have_content("HelloWorld")
  end
end
