class AddRealAcademiaAsCitationToAllTerms < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
	  	INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT every_term, 97, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
			FROM unnest(ARRAY(SELECT id
				  							FROM terms)) every_term
		SQL
  end
end
