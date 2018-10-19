module TermsHelper

	def family?(category)
		category.present? ? "mb-10" : nil
	end

end