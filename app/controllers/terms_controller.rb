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
    @term = Term.new(term_params)

    if @term.save
      flash[:success] = "New entry successfully created!"
      redirect_to "/term/#{@term.slug}"
    elsif @term.errors.any?
      flash[:danger] = "Error: #{@term.errors.full_messages.join(", ")}"
      render "new.html.erb"
    else
      flash[:danger] = "Sorry, your entry did not save. Please try again"
      render "new.html.erb"
    end
  end

  def edit
    @term = Term.find_by_slug(params[:id])
  end

  def update
    @term = Term.find_by_slug(params[:id])

    if @term.update_attributes(term_params)
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
      @terms = Term.includes(:sources)
                   .where(prefix: params[:letter])
                   .order(:slug)
                   .page(params[:page])
    else
      @terms = Term.includes(:sources)
                   .all
                   .order(:slug)
                   .page(params[:page])
    end
  end

  def search
    @results = Term.search(params[:query]).page(params[:page])
    @hit = @results.response.hits.hits.first
  end

  private
    def term_params
      params.permit(:slug, :name, :gender, :prefix_suffix, :part_of_speech, :definition, :etymology1, :etymology2, :uses, :variants, :indo_european_cognates, :romance_cognates, :italic_cognates, :celtic_cognates, :germanic_cognates, :albanian_cognates, :balto_slavic_cognates, :hellenic_cognates, :thracian_cognates, :phrygian_cognates, :messapian_cognates, :armenian_cognates, :indo_iranian_cognates, :tocharian_cognates, :anatolian_cognates, :basque_cognates, :tyrsenian_cognates, :uralic_cognates, :sami_cognates, :finnic_cognates, :mordvinic_cognates, :mari_cognates, :mansi_cognates, :khanty_cognates, :northeast_caucasian_cognates, :nakh_cognates, :lezgic_cognates, :dargwa_cognates, :lak_cognates, :lezghian_cognates, :afro_asiatic_cognates, :egyptian_cognates, :semitic_cognates, :notes1, :notes2)
    end

end
