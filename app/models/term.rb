class Term < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.searchas(load: true) do
      query { string params[:query] } if params[:query].present?
  end

# def self.search(search)
#   if search
#     where 'name LIKE ?', "%#{search}%"
#   else
#     scope
#   end
# end

end
