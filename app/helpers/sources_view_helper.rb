module SourcesViewHelper
  
  def source_styles(field, attribute)
  	if !attribute.present?
  		""
  	elsif field == "book" || field == "website"
			"underline"
		elsif field == "journal"
			"italic"
		end
	end

	def add_period?(attribute)
		attribute.present? ? "." : nil
	end

	def article_period?(article, other)
		if article.present? && other.blank? 
			"."
		end
	end

	def formatted(attribute)
		if attribute.present?
			attribute + "."
		end
	end
	
end
