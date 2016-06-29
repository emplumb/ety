class TermsController < ApplicationController

  def daystamp
    Time.now.strftime("%y%m%d").to_i
  end

  def home
    number_generator = Random.new(daystamp)
    min_term_id = Term.minimum(:id)
    max_term_id = Term.maximum(:id)

    #Will always be the same until daystamp changes or if a new Term is added or removed from the database
    random_term_id = number_generator.rand(min_term_id..max_term_id)

    @term = Term.find(random_term_id)
  end

  def about
  end

  def contact
  end

  def sources
  end

  def appendix
  end

  def phonology
  end

  def show
    @term = Term.find_by_slug(params[:id])
  end

  def directory
    if params[:letter].present?
      @terms = Term.where(prefix: params[:letter]).order(:slug).page(params[:page])
    else
      @terms = Term.all.order(:slug).page(params[:page])
    end
  end

  def search
    @terms = Term.search(params[:query]).page(params[:page])
  end

end
