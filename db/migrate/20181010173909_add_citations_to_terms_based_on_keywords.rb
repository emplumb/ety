class AddCitationsToTermsBasedOnKeywords < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT aa, 28, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%cent.%')) aa
    SQL

    execute <<-SQL
			INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT bb, 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
												FROM terms
												WHERE etymology1 LIKE '%Ancient Greek%'
												OR etymology2 LIKE '%Ancient Greek%'
												OR notes1 LIKE '%Ancient Greek%'
												OR notes2 LIKE '%Ancient Greek%')) bb
    SQL
  end
end
