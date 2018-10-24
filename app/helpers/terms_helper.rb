module TermsHelper

	def family?(category)
		category.present? ? "mb-10" : nil
	end

	def text_area_height(value)
		value.present? ? "4" : "1"
	end

	def is_highlighted_hit?(result, attribute)
		result.try(:highlight).try(attribute)
	end

	def search_response(result, attribute)
		response = is_highlighted_hit?(result, attribute)
		response ? response.first : result['_source'][attribute]		
	end

	def etymology?(term_entry)
		term_entry.etymology1.present? || term_entry.etymology2.present?
	end

	def ie_family?(term_entry)
    term_entry.indo_european_cognates.present? || term_entry.romance_cognates.present? ||
    term_entry.italic_cognates.present? || term_entry.celtic_cognates.present? ||
    term_entry.germanic_cognates.present? || term_entry.albanian_cognates.present? ||
    term_entry.balto_slavic_cognates.present? || term_entry.hellenic_cognates.present? ||
    term_entry.thracian_cognates.present? || term_entry.phrygian_cognates.present? ||
    term_entry.messapian_cognates.present? || term_entry.armenian_cognates.present? ||
    term_entry.indo_iranian_cognates.present? || term_entry.tocharian_cognates.present? ||
    term_entry.anatolian_cognates.present? 
  end

	def uralic_family?(term_entry)
		term_entry.uralic_cognates.present? || term_entry.sami_cognates.present? ||
    term_entry.finnic_cognates.present? || term_entry.mordvinic_cognates.present? ||
    term_entry.mari_cognates.present? || term_entry.mansi_cognates.present? ||
    term_entry.khanty_cognates.present?
	end

	def ne_caucasian_family?(term_entry)
    term_entry.northeast_caucasian_cognates.present? || term_entry.nakh_cognates.present? ||
    term_entry.lezgic_cognates.present? || term_entry.dargwa_cognates.present? ||
    term_entry.lak_cognates.present? || term_entry.lezghian_cognates.present?
  end

  def afro_asiatic_family?(term_entry)
    term_entry.afro_asiatic_cognates.present? || term_entry.egyptian_cognates.present? || term_entry.semitic_cognates.present?
  end

end