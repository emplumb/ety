require 'rails_helper'

RSpec.describe Source, type: :model do
	before(:each) do
		@source = described_class.create(author: "", article: "", other: "editorial", book: "", journal: "", printing: "", year: "2018", website: "www.example.com")
	end

	describe 'Validations' do
		describe 'At least one required field' do
			it 'must be present' do
			  @source.author = "Stephen King"
			  expect(@source).to be_valid
			end
		end

		describe 'If no required field is present' do
			it 'throws error message' do
			  expect(@source).to_not be_valid
  			expect(@source.errors[:base]).to include 'At least one of the following fields must be present: Author, Article, Book, Journal, or Printing'
			end
		end
	end
end