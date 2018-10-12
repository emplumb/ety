class AddRemainingSurnameToponymBasqueCitations < ActiveRecord::Migration[5.0]
  def change
  	execute <<-SQL
	  	INSERT INTO citations (term_id, source_id, created_at, updated_at)		
			SELECT a_var, 113, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE uses LIKE '%surname%' 
												AND id NOT IN (SELECT term_id 
																				FROM citations
																				WHERE source_id = (SELECT id
																														FROM sources
																														WHERE author = 'Tibón, G')))) a_var
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)		
			SELECT a_var, 113, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE uses LIKE '%toponym%' 
												AND id NOT IN (SELECT term_id 
																				FROM citations
																				WHERE source_id = 113))) a_var
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)		
			SELECT a_var, 117, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE uses LIKE '%Basque%' 
												AND id NOT IN (SELECT term_id 
																				FROM citations
																				WHERE source_id = 117))) a_var
		SQL
  end
end
