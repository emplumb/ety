class SourcesController < ApplicationController

  def index
    @sources = Source.all
  end

  def show
    @source = Source.find(params[:id])
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    @source.title = params[:title]

    if @source.save
      flash[:success] = "Source successfully updated"
      redirect_to "/source/#{@source.id}"
    else
      flash[:danger] = "Error: #{@source.errors.full_messages.to_sentence}"
      redirect_to "/source/#{@source.id}/edit"
    end
  end

end
