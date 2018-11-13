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

	def etymology?(entry)
		entry.etymology1.present? || entry.etymology2.present?
	end

	def ie_family?(entry)
    entry.indo_european_cognates.present? || entry.romance_cognates.present? ||
    entry.italic_cognates.present? || entry.celtic_cognates.present? ||
    entry.germanic_cognates.present? || entry.albanian_cognates.present? ||
    entry.balto_slavic_cognates.present? || entry.hellenic_cognates.present? ||
    entry.thracian_cognates.present? || entry.phrygian_cognates.present? ||
    entry.messapian_cognates.present? || entry.armenian_cognates.present? ||
    entry.indo_iranian_cognates.present? || entry.tocharian_cognates.present? ||
    entry.anatolian_cognates.present? 
  end

	def uralic_family?(entry)
		entry.uralic_cognates.present? || entry.sami_cognates.present? ||
    entry.finnic_cognates.present? || entry.mordvinic_cognates.present? ||
    entry.mari_cognates.present? || entry.mansi_cognates.present? ||
    entry.khanty_cognates.present?
	end

	def ne_caucasian_family?(entry)
    entry.northeast_caucasian_cognates.present? || entry.nakh_cognates.present? ||
    entry.lezgic_cognates.present? || entry.dargwa_cognates.present? ||
    entry.lak_cognates.present? || entry.lezghian_cognates.present?
  end

  def afro_asiatic_family?(entry)
    entry.afro_asiatic_cognates.present? || entry.egyptian_cognates.present? || entry.semitic_cognates.present?
  end

end