class InsertLatinAncientGreekDworkinPennyRixCitations < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
  		INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT a_var, 108, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%Latin%'
												OR etymology2 LIKE '%Latin%'
												OR notes1 LIKE '%Latin%'
												OR notes2 LIKE '%Latin%'
												OR uses LIKE '%Latin%')) a_var
		SQL

		execute <<-SQL					
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT a_var, 108, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id												FROM terms
												WHERE etymology1 LIKE '%Ancient Greek%'
												OR etymology2 LIKE '%Ancient Greek%'
												OR notes1 LIKE '%Ancient Greek%'
												OR notes2 LIKE '%Ancient Greek%'
												OR uses LIKE '%Ancient Greek%')) a_var
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT a_var, 39, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id												FROM terms
												WHERE etymology1 LIKE '%Dworkin%'
												OR etymology2 LIKE '%Dworkin%'
												OR notes1 LIKE '%Dworkin%'
												OR notes2 LIKE '%Dworkin%'
												OR uses LIKE '%Dworkin%')) a_var
		SQL

		execute <<-SQL					
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT a_var, 87, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%Penny%'
												OR etymology2 LIKE '%Penny%'
												OR notes1 LIKE '%Penny%'
												OR notes2 LIKE '%Penny%'
												OR uses LIKE '%Penny%')) a_var
		SQL

		execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT a_var, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%Rix%'
												OR etymology2 LIKE '%Rix%'
												OR notes1 LIKE '%Rix%'
												OR notes2 LIKE '%Rix%'
												OR uses LIKE '%Rix%')) a_var
		SQL
  end
end
