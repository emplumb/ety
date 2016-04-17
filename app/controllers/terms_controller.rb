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
      @terms = Term.where(first: params[:letter]).order(:name).page(params[:page])
    else
      @terms = Term.all.order(:name).page(params[:page])
    end
  end

  def search
      @terms = Term.search(params[:query]).page(params[:page])
  end



end
