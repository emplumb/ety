class TermsController < ApplicationController

  def home
  end

  def about
  end

  def contact
  end

  def show
    @term = Term.find_by_name(params[:name])
  end

  def directory
    if params[:letter].present?
      @terms = Term.where(first: params[:letter]).order(:name)
    else
      @terms = Term.all.order(:name)
    end
  end

  def search

    # if params[:query].blank?
    #   @terms = Term.all.order(:name)
    # else
    #   @terms = Term.search(params[:query]).results
    # end

    @terms = Term.search(params[:query]).results

    # @terms = Term.search query:     { match:  { notes1: "Latin" } },
                              # highlight: { fields: { notes1: {} } }

    # response.results.first.highlight.notes1

# @terms = Term.custom_search((params[:query].present? ? params[:query] : '*')).results
  end


end
