class AddFixedLatinAndGreekQueryAndOthers < ActiveRecord::Migration[5.0]
  def change
  	execute <<-SQL
  		INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT a_var, 108, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT DISTINCT id
												FROM terms
												WHERE etymology1 LIKE '%Latin%'
												OR etymology2 LIKE '%Latin%'
												OR notes1 LIKE '%Latin%'
												OR notes2 LIKE '%Latin%'
												OR uses LIKE '%Latin%'
												OR etymology1 LIKE '%Ancient Greek%'
												OR etymology2 LIKE '%Ancient Greek%'
												OR notes1 LIKE '%Ancient Greek%'
												OR notes2 LIKE '%Ancient Greek%'
												OR uses LIKE '%Ancient Greek%')) a_var
		SQL
  end

  
end
