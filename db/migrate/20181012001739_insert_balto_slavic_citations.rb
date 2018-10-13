class InsertBaltoSlavicCitations < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
	  	INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT term_ids_var, source_ids_var, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%Balto-Slavic%'
												OR etymology2 LIKE '%Balto-Slavic%'
												OR notes1 LIKE '%Balto-Slavic%'
												OR notes2 LIKE '%Balto-Slavic%'
												OR uses LIKE '%Balto-Slavic%')) term_ids_var,
					 unnest(ARRAY(SELECT id
												FROM sources
												WHERE author LIKE 'Derksen%')) source_ids_var
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT term_ids_var, 36, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE slug = 'corazon'
												OR slug = 'robot'
												OR slug = 'fabro'
												OR slug = 'padre'
												OR slug = 'linea')) term_ids_var
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT term_ids_var, 35, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE slug = 'humano'
												OR slug = 'linea'
												OR slug = 'fabro')) term_ids_var
		SQL
  end
end
