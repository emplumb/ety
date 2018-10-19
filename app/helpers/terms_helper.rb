module TermsHelper

	def family?(category)
		category.present? ? "mb-10" : nil
	end

	def text_area_height(value)
		value.present? ? "4" : "1"
	end

end