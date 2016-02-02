class TermsController < ApplicationController

  def home
  end

  def about
  end

  def letter
    @letter = ['A' .. 'Z']

  end

  def show
    # @term = Term.find(params[:id])
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
    #is nil necessary?
    if params[:q].nil? || params[:q].blank?
      @terms = Term.all.order(:name)
    else
      @terms = Term.search params[:q]
    end
  end


end
