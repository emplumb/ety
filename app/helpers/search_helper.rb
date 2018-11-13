module SearchHelper

	def search_page_title(query_param)
		if query_param.blank?
			return "No query found"
		end

		return query_param + " - search results"
	end

end
