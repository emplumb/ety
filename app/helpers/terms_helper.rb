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

end