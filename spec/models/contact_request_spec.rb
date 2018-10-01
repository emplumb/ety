require 'rails_helper'

RSpec.describe ContactRequest, type: :model do
	before(:each) do
		@contact = ContactRequest.new(first_name: "The", last_name: "Rock", subject: "If ya smell...", body: "what The Rock is cookin!", email: "the@rock.com")
	end

	describe 'Validations' do
		describe 'First name' do
			it 'must be present' do
			  expect(@contact).to be_valid
			  @contact.first_name = nil
			  expect(@contact).to_not be_valid
			end
		end

		describe 'Last name' do
			it 'must be present' do
				expect(@contact).to be_valid
			  @contact.last_name = nil
			  expect(@contact).to_not be_valid
			end
		end

		describe 'subject' do
			it 'must be present' do
				expect(@contact).to be_valid
			  @contact.subject = nil
			  expect(@contact).to_not be_valid
			end
		end

		describe 'body' do
			it 'must be present' do
				expect(@contact).to be_valid
			  @contact.body = nil
			  expect(@contact).to_not be_valid
			end
		end
		
		describe 'email' do
			it 'must be present' do
				expect(@contact).to be_valid
			  @contact.email = nil
			  expect(@contact).to_not be_valid
			end

			it 'must have a valid email pattern' do
			  @contact.update(email: "myfakeemailaddress")
			  expect(@contact).to_not be_valid
			end
		end
	end
end