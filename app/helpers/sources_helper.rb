module SourcesHelper
	def sorted_sources_sql
		"LOWER(COALESCE(NULLIF(author, ''), NULLIF(article, ''), NULLIF(other, ''), NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))), 
		LOWER(COALESCE(NULLIF(article, ''), NULLIF(other, ''), NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))), 
		LOWER(COALESCE(NULLIF(other, ''), NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))),
		LOWER(COALESCE(NULLIF(book, ''), NULLIF(journal, ''), NULLIF(printing, ''))), 
		LOWER(COALESCE(NULLIF(journal, ''), NULLIF(printing, ''))),
		LOWER(printing)"
  end
end
