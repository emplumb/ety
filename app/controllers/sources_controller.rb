class SourcesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @sources = Source.sort_all
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.new(
      author: params[:author],
      article: params[:article],
      other: params[:other],
      book: params[:book],
      journal: params[:journal],
      printing: params[:printing],
      year: params[:year],
      website: params[:website]
    )

    if @source.save
      flash[:success] = "New source successfully created!"
      redirect_to "/sources"
    elsif @source.errors.any?
      flash[:danger] = "Error: #{@source.errors.full_messages.join(", ")}"
      render "new.html.erb"
    else
      flash[:danger] = "Sorry, your source did not save. Please try again."
      render "new.html.erb"
    end
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    @source.author = params[:author]
    @source.article = params[:article]
    @source.other = params[:other]
    @source.book = params[:book]
    @source.journal = params[:journal]
    @source.printing = params[:printing]
    @source.year = params[:year]
    @source.website = params[:website]

    if @source.save
      flash[:success] = "Source successfully updated"
      redirect_to "/sources"
    else
      flash[:danger] = "Error: #{@source.errors.full_messages.to_sentence}"
      redirect_to "/source/#{@source.id}/edit"
    end
  end

  def destroy
    @source = Source.find(params[:id])
    
    if @source.destroy
      flash[:warning] = "Source has been successfully deleted."
      redirect_to "/sources"
    else
      flash[:danger] = "Error: source cannot be deleted. Please contact administrator if problem persists."
      render 'edit.html.erb'
    end
  end

end
