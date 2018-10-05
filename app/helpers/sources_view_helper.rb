module SourcesViewHelper
  
  def source_styles(attribute)
		if attribute == book
			"underline"
		elsif attribute == journal
			"italic"
		end
	end

	def add_period(attribute)
		attribute.present? ? "." : nil
	end

	def author_formatted
		if author.present?
			author + "."
		end
	end

	def article_formatted
		if article.present? && other.blank?
			'"' + article + '."'
		elsif article.present? && other.present?
			'"' + article + '"'
		end
	end

	def printing_formatted
		if printing.present?
			printing + "."
		end
	end

	def year_formatted
		if year.present?
			year + "."
		end
	end

	def website_formatted
		if website.present?
			website + "."
		end
	end
	
end
