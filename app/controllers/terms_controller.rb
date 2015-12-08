class TermsController < ApplicationController
  def index
    @terms = Term.all
  end

  def show

    # @term = Term.find(params[:id])
    @term = Term.find_by_name(params[:name])
  end

  def directory
    @terms = Term.search(params)


  end

  def new
    @term = Term.new
  end

  def create
    @term = Term.new
    @term.name = params[:name]
    @term.gender = params[:gender]
    @term.part_of_speech = params[:part_of_speech]
    @term.definition = params[:definition]
    @term.etymology1 = params[:etymology1]
    @term.etymology2 = params[:etymology2]
    @term.uses = params[:uses]
    @term.romance_cognates = params[:romance_cognates]
    @term.notes1 = params[:notes1]
    @term.notes2 = params[:notes2]
    @term.quote1 = params[:quote1]
    @term.quote2 = params[:quote2]

    if @term.save
      redirect_to "/terms", :notice => "Term created successfully."
    else
      render 'new'
    end
  end

  def edit
    @term = Term.find(params[:id])
  end

  def update
    @term = Term.find(params[:id])

    @term.name = params[:name]
    @term.gender = params[:gender]
    @term.part_of_speech = params[:part_of_speech]
    @term.definition = params[:definition]
    @term.etymology1 = params[:etymology1]
    @term.etymology2 = params[:etymology2]
    @term.uses = params[:uses]
    @term.romance_cognates = params[:romance_cognates]
    @term.notes1 = params[:notes1]
    @term.notes2 = params[:notes2]
    @term.quote1 = params[:quote1]
    @term.quote2 = params[:quote2]

    if @term.save
      redirect_to "/terms", :notice => "Term updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @term = Term.find(params[:id])

    @term.destroy

    redirect_to "/terms", :notice => "Term deleted."
  end
end
