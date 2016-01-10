class TermsController < ApplicationController

  def show

    # @term = Term.find(params[:id])
    @term = Term.find_by_name(params[:name])
  end

  def directory
    if params[:letter].present?
      @terms = Term.where(first: params[:letter])
    else
      @terms = Term.all.order(:name)
    end


  end


end
