class FixLinks < ActiveRecord::Migration[5.0]
  def change
  	execute <<-SQL
  		UPDATE terms
			SET etymology1 = REPLACE (etymology1, '=''/term/', '=''/terms/'),
					etymology2 = REPLACE (etymology2, '=''/term/', '=''/terms/'),
					uses = REPLACE (uses, '=''/term/', '=''/terms/'),
					variants = REPLACE (variants, '=''/term/', '=''/terms/'),
					indo_european_cognates = REPLACE (indo_european_cognates, '=''/term/', '=''/terms/'),
					romance_cognates = REPLACE (romance_cognates, '=''/term/', '=''/terms/'),
					italic_cognates = REPLACE (italic_cognates, '=''/term/', '=''/terms/'),
					celtic_cognates = REPLACE (celtic_cognates, '=''/term/', '=''/terms/'),
					germanic_cognates = REPLACE (germanic_cognates, '=''/term/', '=''/terms/'),
					albanian_cognates = REPLACE (albanian_cognates, '=''/term/', '=''/terms/'),
					balto_slavic_cognates = REPLACE (balto_slavic_cognates, '=''/term/', '=''/terms/'),
					hellenic_cognates = REPLACE (hellenic_cognates, '=''/term/', '=''/terms/'),
					thracian_cognates = REPLACE (thracian_cognates, '=''/term/', '=''/terms/'),
					phrygian_cognates = REPLACE (phrygian_cognates, '=''/term/', '=''/terms/'),
					messapian_cognates = REPLACE (messapian_cognates, '=''/term/', '=''/terms/'),
					armenian_cognates = REPLACE (armenian_cognates, '=''/term/', '=''/terms/'),
					indo_iranian_cognates = REPLACE (indo_iranian_cognates, '=''/term/', '=''/terms/'),
					tocharian_cognates = REPLACE (tocharian_cognates, '=''/term/', '=''/terms/'),
					anatolian_cognates = REPLACE (anatolian_cognates, '=''/term/', '=''/terms/'),
					basque_cognates = REPLACE (basque_cognates, '=''/term/', '=''/terms/'),
					tyrsenian_cognates = REPLACE (tyrsenian_cognates, '=''/term/', '=''/terms/'),
					uralic_cognates = REPLACE (uralic_cognates, '=''/term/', '=''/terms/'),
					sami_cognates = REPLACE (sami_cognates, '=''/term/', '=''/terms/'),
					finnic_cognates = REPLACE (finnic_cognates, '=''/term/', '=''/terms/'),
					mordvinic_cognates = REPLACE (mordvinic_cognates, '=''/term/', '=''/terms/'),
					mari_cognates = REPLACE (mari_cognates, '=''/term/', '=''/terms/'),
					mansi_cognates = REPLACE (mansi_cognates, '=''/term/', '=''/terms/'),
					khanty_cognates = REPLACE (khanty_cognates, '=''/term/', '=''/terms/'),
					northeast_caucasian_cognates = REPLACE (northeast_caucasian_cognates, '=''/term/', '=''/terms/'),
					nakh_cognates = REPLACE (nakh_cognates, '=''/term/', '=''/terms/'),
					lezgic_cognates = REPLACE (lezgic_cognates, '=''/term/', '=''/terms/'),
					dargwa_cognates = REPLACE (dargwa_cognates, '=''/term/', '=''/terms/'),
					lak_cognates = REPLACE (lak_cognates, '=''/term/', '=''/terms/'),
					lezghian_cognates = REPLACE (lezghian_cognates, '=''/term/', '=''/terms/'),
					afro_asiatic_cognates = REPLACE (afro_asiatic_cognates, '=''/term/', '=''/terms/'),
					egyptian_cognates = REPLACE (egyptian_cognates, '=''/term/', '=''/terms/'),
					semitic_cognates = REPLACE (semitic_cognates, '=''/term/', '=''/terms/'),
					notes1 = REPLACE (notes1, '=''/term/', '=''/terms/'),
					notes2 = REPLACE (notes2, '=''/term/', '=''/terms/')
		SQL
  end
end