class TermsController < ApplicationController

  def daystamp
    Time.now.strftime("%y%m%d").to_i
  end

  def home
    number_generator = Random.new(daystamp)
    min_term_id = Term.minimum(:id)
    max_term_id = Term.maximum(:id)
    random_term_id = number_generator.rand(min_term_id..max_term_id)
    # this random_term_id will always be the same until daystamp changes
    # or a new Term is added or removed from the database

    @term = Term.find(random_term_id)
  end

  def about
  end

  def faq
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
