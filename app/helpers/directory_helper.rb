module DirectoryHelper

	def dir_page_title(letter_param)
		if !letter_param.present?
			return
		end

		if letter_param == 'ñ'
			return 'Ñ'
		else
			return letter_param.upcase
		end
	end

end
