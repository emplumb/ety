class TermsController < ApplicationController

  def home
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
      @terms = Term.search params[:query]
  end


end
