class TermsController < ApplicationController

  def show

    # @term = Term.find(params[:id])
    @term = Term.find_by_name(params[:name])
  end

  def directory
    if params[:letter].present?
      puts "gggggggggggggggggggggggggggggggggggggggggggggggggggggggg"
    end
    @terms = Term.all.order(:name)

  end


end
