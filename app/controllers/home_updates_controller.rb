class HomeUpdatesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

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

  def home
    @posts = HomeUpdate.where.not(title: "Welcome").order(created_at: :desc).limit(3)
    @welcome_post = HomeUpdate.find_by(title: "Welcome")

    return word_of_day
  end

  def new
  	@post = HomeUpdate.new
  end

  def create
  	@post = HomeUpdate.new(
      title: params[:title],
      body: params[:body],
    )

    if @post.save
      flash[:success] = "New entry successfully created!"
      redirect_to root_path
    elsif @post.errors.any?
      flash[:danger] = "Error: #{@post.errors.full_messages.join(", ")}"
      render "new.html.erb"
    else
      flash[:danger] = "Sorry, your entry did not save."
      render "new.html.erb"
    end
  end

  def edit
    @post = HomeUpdate.find(params[:id])
  end

  def update
    post = HomeUpdate.find(params[:id])
    post.title = params[:title]
    post.body = params[:body]

    if post.save
      flash[:success] = "Entry successfully updated"
      redirect_to root_path
    else
      flash[:danger] = "Error: #{post.errors.full_messages.to_sentence}"
      redirect_to "/home/update/#{post.id}/edit"
    end
  end

  def destroy
    @post = HomeUpdate.find(params[:id])
    
    if @post.destroy
      flash[:warning] = "Post has been successfully deleted."
      redirect_to "/"
    else
      flash[:danger] = "Error: post cannot be deleted. Please contact administrator if problem persists."
      render 'edit.html.erb'
    end
  end

end
