class TermsController < ApplicationController

  def show
    # @term = Term.find(params[:id])
    @term = Term.find_by_name(params[:name])
  end

  def directory

#second if/then statement negates first one
    if params[:letter].present?
      @terms = Term.where(first: params[:letter]).order(:name)
    else
      @terms = Term.all.order(:name)
    end
#is nil necessary?
    if params[:q].nil? || params[:q].blank?
      @terms = Term.all.order(:name)
    else
      @terms = Term.search params[:q]
    end



  end


end
