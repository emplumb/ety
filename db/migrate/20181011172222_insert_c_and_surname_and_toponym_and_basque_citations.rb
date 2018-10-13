class InsertCAndSurnameAndToponymAndBasqueCitations < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
	  	INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT aa, 28, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												From terms
												Where etymology1 LIKE 'C.%')) aa
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT bb, 113, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%surname%'
												OR etymology2 LIKE '%surname%'
												OR notes1 LIKE '%surname%'
												OR notes2 LIKE '%surname%')) bb
		SQL

		execute <<-SQL				
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT cc, 113, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%toponym%'
												OR etymology2 LIKE '%toponym%'
												OR notes1 LIKE '%toponym%'
												OR notes2 LIKE '%toponym%')) cc
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT dd, 117, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%Basque%'
												OR etymology2 LIKE '%Basque%'
												OR notes1 LIKE '%Basque%'
												OR notes2 LIKE '%Basque%')) dd
		SQL
  end
end
