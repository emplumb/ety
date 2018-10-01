require 'rails_helper'

RSpec.describe AboutPage, type: :model do
	page = AboutPage.new(body: "Spanish etymology is great")
	
	describe 'Validations' do
		describe 'Body' do
			it "must be present" do
			  expect(page).to be_valid
			  page.body = nil
			  expect(page).to_not be_valid
			end
		end
	end
end

