class AddCitationsForProtoItalicAndGermanicSources < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
	  	INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT a_var, 34, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												From terms
												where etymology1 LIKE '%Proto-Italic%'
												OR etymology2 LIKE '%Proto-Italic%'
												OR notes1 LIKE '%Proto-Italic%'
												OR notes2 LIKE '%Proto-Italic%')) a_var
		SQL
			
		execute <<-SQL		
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT b_var, 59, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												From terms
												where etymology1 LIKE '%Proto-Germanic%'
												OR etymology2 LIKE '%Proto-Germanic%'
												OR notes1 LIKE '%Proto-Germanic%'
												OR notes2 LIKE '%Proto-Germanic%')) b_var
		SQL
  end
end
