class TermsController < ApplicationController
  include SourcesHelper
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  
  def show
    @term = Term.includes(:sources)
                .order(sorted_sources_sql)
                .references(:citations)
                .find_by_slug(params[:id])
  end

  def new
    @term = Term.new
  end

  def create
    @term = Term.new(
      slug: params[:id],
      name: params[:name],
      gender: params[:gender],
      p_s: params[:p_s],
      part_of_speech: params[:part_of_speech],
      definition: params[:definition],
      etymology1: params[:etymology1],
      etymology2: params[:etymology2],
      uses: params[:uses],
      variants: params[:variants],
      romance_cognates: params[:romance_cognates],
      italic_cognates: params[:italic_cognates],
      etruscan: params[:etruscan],
      celtic_cognates: params[:celtic_cognates],
      germanic_cognates: params[:germanic_cognates],
      baltoslavic_cognates: params[:baltoslavic_cognates],
      albanian_cognates: params[:albanian_cognates],
      hellenic_cognates: params[:hellenic_cognates],
      armenian_cognates: params[:armenian_cognates],
      indoiranian_cognates: params[:indoiranian_cognates],
      semitic: params[:semitic],
      uralic: params[:uralic],
      ne_caucasian: params[:ne_caucasian],
      ie_cognates: params[:ie_cognates],
      notes1: params[:notes1],
      notes2: params[:notes2],
      quote: params[:quote]
    )

    if @term.save
      flash[:success] = "New entry successfully created!"
      redirect_to "/term/#{@term.slug}"
    elsif @term.errors.any?
      flash[:danger] = "Error: #{@term.errors.full_messages.join(", ")}"
      render "new.html.erb"
    else
      flash[:danger] = "Sorry, your entry did not save."
      render "new.html.erb"
    end
  end

  def edit
    @term = Term.find_by_slug(params[:id])
  end

  def update
    @term = Term.find_by_slug(params[:id])
    @term.slug = params[:id]
    @term.name = params[:name]
    @term.gender = params[:gender]
    @term.p_s = params[:p_s]
    @term.part_of_speech = params[:part_of_speech]
    @term.definition = params[:definition]
    @term.etymology1 = params[:etymology1]
    @term.etymology2 = params[:etymology2]
    @term.uses = params[:uses]
    @term.variants = params[:variants]
    @term.romance_cognates = params[:romance_cognates]
    @term.italic_cognates = params[:italic_cognates]
    @term.etruscan = params[:etruscan]
    @term.celtic_cognates = params[:celtic_cognates]
    @term.germanic_cognates = params[:germanic_cognates]
    @term.baltoslavic_cognates = params[:baltoslavic_cognates]
    @term.albanian_cognates = params[:albanian_cognates]
    @term.hellenic_cognates = params[:hellenic_cognates]
    @term.armenian_cognates = params[:armenian_cognates]
    @term.indoiranian_cognates = params[:indoiranian_cognates]
    @term.semitic = params[:semitic]
    @term.uralic = params[:uralic]
    @term.ne_caucasian = params[:ne_caucasian]
    @term.ie_cognates = params[:ie_cognates]
    @term.notes1 = params[:notes1]
    @term.notes2 = params[:notes2]
    @term.quote = params[:quote]

    if @term.save
      flash[:success] = "Entry successfully updated"
      redirect_to "/term/#{@term.slug}"
    else
      flash[:danger] = "Error: #{@term.errors.full_messages.to_sentence}"
      redirect_to "/term/#{@term.slug}/edit"
    end
  end

  def destroy
    @term = Term.find_by_slug(params[:id])
    
    if @term.destroy
      flash[:warning] = "Term has been successfully deleted."
      redirect_to root_path
    else
      flash[:danger] = "Error: term cannot be deleted. Please contact administrator if problem persists."
      render 'edit.html.erb'
    end
  end

  def directory
    if params[:letter].present?
      @terms = Term.where(prefix: params[:letter]).order(:slug).page(params[:page])
    else
      @terms = Term.all.order(:slug).page(params[:page])
    end
  end

  def search
    @results = Term.search(params[:query]).page(params[:page])
    @hit = @results.response.hits.hits.first
  end

end
