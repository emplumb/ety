class HomeUpdatesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]

  def daystamp
    Time.now.strftime("%y%m%d").to_i
  end

  def word_of_day
    number_generator = Random.new(daystamp)
    min_term_id = Term.minimum(:id)
    max_term_id = Term.maximum(:id)

    #Will always be the same until daystamp changes or if a new Term is added or removed from the database
    random_term_id = number_generator.rand(min_term_id..max_term_id)

    @term = Term.find(random_term_id)
  end

  def index
    @welcome = HomeUpdate.first
    @posts = HomeUpdate.limit(2).order(created_at: :desc)

    return word_of_day
  end

  def new
  end

  def edit
    @post = HomeUpdate.find(params[:id])
  end

  def update
    post = HomeUpdate.find(params[:id])
    post.title = params[:title]
    post.body = params[:body]
  end

  def destroy
    @post = HomeUpdate.find(params[:id])
  end
end
