require 'rails_helper'

RSpec.describe PhonologyPage, type: :model do
	before(:each) do
		@description = PhonologyPage.new(body: "Phonology page")
	end

	describe 'Validations' do
		describe 'Body' do
			it 'must be present' do
			  expect(@description).to be_valid
			  @description.body = nil
			  expect(@description).to_not be_valid
			end
		end
	end
end