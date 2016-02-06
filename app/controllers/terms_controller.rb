class TermsController < ApplicationController

  def home
  end
<<<<<<< HEAD

  def about
  end

  def letter
    @letter = ['A' .. 'Z']

  end

  def show
    # @term = Term.find(params[:id])
=======

  def show
>>>>>>> es-setup
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
<<<<<<< HEAD
    #is nil necessary?
    if params[:q].nil? || params[:q].blank?
      @terms = Term.all.order(:name)
    else
      @terms = Term.search params[:q]
    end
=======
      @terms = Term.search params[:query]
>>>>>>> es-setup
  end


end
