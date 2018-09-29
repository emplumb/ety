require 'rails_helper'

RSpec.describe AboutPage, type: :model do
	it "is not valid without a body" do
		page = AboutPage.create
	  expect(page).to_not be_valid
	end
end

