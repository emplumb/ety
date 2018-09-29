require 'rails_helper'

RSpec.describe ContactRequest, type: :model do
	before(:each) do
		@post = HomeUpdate.new(title: "September Update", body: "We've added a bunch of words")
	end

	describe 'Validations' do
		describe 'Title' do
			it 'must be present' do
			  expect(@post).to be_valid
			  @post.title = nil
			  expect(@post).to_not be_valid
			end
		end

		describe 'Body' do
			it 'must be present' do
				expect(@post).to be_valid
			  @post.body = nil
			  expect(@post).to_not be_valid
			end
		end
	end
end