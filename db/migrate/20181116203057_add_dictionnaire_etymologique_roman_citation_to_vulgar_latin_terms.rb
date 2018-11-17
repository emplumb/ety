class AddDictionnaireEtymologiqueRomanCitationToVulgarLatinTerms < ActiveRecord::Migration[5.0]
  def up
  	execute <<-SQL
	  	INSERT INTO citations (term_id, source_id, created_at, updated_at)
			SELECT id, 
				     (SELECT id FROM sources WHERE journal = 'Dictionnaire Étymologique Roman'),
				      CURRENT_TIMESTAMP, 
				      CURRENT_TIMESTAMP
			FROM terms
			WHERE id IN (SELECT id
										FROM terms
										WHERE etymology1 LIKE '%Vulgar Latin%'
										OR etymology2 LIKE '%Vulgar Latin%'
										OR uses LIKE '%Vulgar Latin%'
										OR variants LIKE '%Vulgar Latin%'
										OR indo_european_cognates LIKE '%Vulgar Latin%'
										OR romance_cognates LIKE '%Vulgar Latin%'
										OR italic_cognates LIKE '%Vulgar Latin%'
										OR celtic_cognates LIKE '%Vulgar Latin%'
										OR germanic_cognates LIKE '%Vulgar Latin%'
										OR albanian_cognates LIKE '%Vulgar Latin%'
										OR balto_slavic_cognates LIKE '%Vulgar Latin%'
										OR hellenic_cognates LIKE '%Vulgar Latin%'
										OR thracian_cognates LIKE '%Vulgar Latin%'
										OR phrygian_cognates LIKE '%Vulgar Latin%'
										OR messapian_cognates LIKE '%Vulgar Latin%'
										OR armenian_cognates LIKE '%Vulgar Latin%'
										OR indo_iranian_cognates LIKE '%Vulgar Latin%'
										OR tocharian_cognates LIKE '%Vulgar Latin%'
										OR anatolian_cognates LIKE '%Vulgar Latin%'
										OR basque_cognates LIKE '%Vulgar Latin%'
										OR tyrsenian_cognates LIKE '%Vulgar Latin%'
										OR uralic_cognates LIKE '%Vulgar Latin%'
										OR sami_cognates LIKE '%Vulgar Latin%'
										OR finnic_cognates LIKE '%Vulgar Latin%'
										OR mordvinic_cognates LIKE '%Vulgar Latin%'
										OR mari_cognates LIKE '%Vulgar Latin%'
										OR mansi_cognates LIKE '%Vulgar Latin%'
										OR khanty_cognates LIKE '%Vulgar Latin%'
										OR northeast_caucasian_cognates LIKE '%Vulgar Latin%'
										OR nakh_cognates LIKE '%Vulgar Latin%'
										OR lezgic_cognates LIKE '%Vulgar Latin%'
										OR dargwa_cognates LIKE '%Vulgar Latin%'
										OR lak_cognates LIKE '%Vulgar Latin%'
										OR lezghian_cognates LIKE '%Vulgar Latin%'
										OR afro_asiatic_cognates LIKE '%Vulgar Latin%'
										OR egyptian_cognates LIKE '%Vulgar Latin%'
										OR semitic_cognates LIKE '%Vulgar Latin%'
										OR notes1 LIKE '%Vulgar Latin%'
										OR notes2 LIKE '%Vulgar Latin%')
		SQL
  end
end
