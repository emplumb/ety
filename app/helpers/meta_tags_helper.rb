module MetaTagsHelper

  DEFAULT_PAGE_TITLE = "Etymological Dictionary of Spanish (OEDoS)"
  DEFAULT_PAGE_DESCRIPTION = "Etymology is not a defintion but a history of a word over time. Search our comprehensive Spanish etymological dictionary to learn about your favorite words!"
  DEFAULT_DIR_DESCRIPTION = "Browse through all the Spanish words in our dictionary"
  
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : DEFAULT_PAGE_TITLE
  end

  def meta_description
    content_for?(:meta_description) ? format_description(content_for(:meta_description)) : DEFAULT_PAGE_DESCRIPTION
  end

  def format_description(description)
    without_tags = strip_tags(description)
    without_tags.truncate(160, separator: ' ')
  end

  def uppercase_letter(letter_param)
    if letter_param.present?
      if letter_param == 'ñ'
        return 'Ñ'
      else
        return letter_param.upcase
      end
    end
  end

  def dir_page_description(letter_param)
    if letter_param.present?
      return DEFAULT_DIR_DESCRIPTION + " that begin with #{uppercase_letter(letter_param)}" 
    end

    return DEFAULT_DIR_DESCRIPTION
  end

end