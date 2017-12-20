class AboutPagesController < ApplicationController
	def show
		@about_page = AboutPage.first
	end

	def edit
    @about_page = AboutPage.find(params[:id])
  end

  def update
    @about_page = AboutPage.find(params[:id])
    @about_page.quote = params[:quote]
    @about_page.body = params[:body]

    if @about_page.save
      flash[:success] = "Changes successfully updated"
      redirect_to "/about"
    else
      flash[:danger] = "Error: #{@about_page.errors.full_messages.to_sentence}"
      redirect_to "/about/#{@about_page.id}/edit"
    end
  end

end
