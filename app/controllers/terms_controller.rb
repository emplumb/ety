class TermsController < ApplicationController

  def show

    # @term = Term.find(params[:id])
    @term = Term.find_by_name(params[:name])
  end

  def directory
    if params[:letter].present?
      #Is .order(:name) necessary?
      @terms = Term.where(first: params[:letter]).order(:name)
    else
      @terms = Term.all.order(:name)
    end
  end


end
