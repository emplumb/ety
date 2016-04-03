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
      @terms = Term.all.order(:name).page(params[:page]).per(5)
    end
  end

  def search
    if params[:query].blank?
      @terms = Term.all.order(:name)
    else
      @terms = Term.search(params[:query]).page(params[:page]).per(5)
    end
  end


end
