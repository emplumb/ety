class Source < ApplicationRecord
  has_many :citations
  has_many :terms, through: :citations

	validate :required_field_present?, on: [:create, :update]

	def required_field_present?
		required_field = %w(author article book journal printing).all? { |field| self[field].blank? }

	  if required_field
	    errors.add :base, "At least one of the following fields must be present: Author, Article, Book, Journal, or Printing"
	  end
	end

	private
		def self.sort_all
			query = <<-SQL
	      SELECT sources.*
	      FROM sources
	      ORDER BY 
		      LOWER(COALESCE(NULLIF(author, ''), NULLIF(article, ''), NULLIF(other, ''), NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))), 
		      LOWER(COALESCE(NULLIF(article, ''), NULLIF(other, ''), NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))), 
		      LOWER(COALESCE(NULLIF(other, ''), NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))),
		      LOWER(COALESCE(NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))), 
		      LOWER(COALESCE(NULLIF(journal, ''), NULLIF(printing, ''))),
		      LOWER(printing)
	    SQL

	    self.find_by_sql(query)
		end
end
