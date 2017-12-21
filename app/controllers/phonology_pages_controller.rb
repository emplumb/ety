class PhonologyPagesController < ApplicationController
	def show
		@phonology_page = PhonologyPage.first
	end

	def edit
    @phonology_page = PhonologyPage.find(params[:id])
  end

  def update
    @phonology_page = PhonologyPage.find(params[:id])
    @phonology_page.body = params[:body]

    if @phonology_page.save
      flash[:success] = "Changes successfully updated"
      redirect_to "/phonology"
    else
      flash[:danger] = "Error: #{@phonology_page.errors.full_messages.to_sentence}"
      redirect_to "/phonology/#{@phonology_page.id}/edit"
    end
  end
end
