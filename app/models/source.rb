class Source < ApplicationRecord

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
