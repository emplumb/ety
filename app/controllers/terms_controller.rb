class TermsController < ApplicationController

  def daystamp
    Time.now.strftime("%y%m%d").to_i
  end

  def home
    number_generator = Random.new(daystamp)
    min_term_id = Term.minimum(:id)
    max_term_id = Term.maximum(:id)

    #Will always be the same until daystamp changes or if a new Term is added or removed from the database
    random_term_id = number_generator.rand(min_term_id..max_term_id)

    @term = Term.find(random_term_id)
  end

  def about
  end

  def contact
  end

  def sources
  end

  def appendix
  end

  def phonology
  end

  def show
    @term = Term.find_by_slug(params[:id])
  end

  def edit
  end

  def update
    term = Term.find_by_slug(params[:id])
    term.name = params[:name]
    term.prefix = params[:prefix]
    term.gender = params[:gender]
    term.p_s = params[:p_s]
    term.part_of_speech = params[:part_of_speech]
    term.definition = params[:definition]
    term.etymology1 = params[:etymology1]
    term.etymology2 = params[:etymology2]
    term.uses = params[:uses]
    term.variants = params[:variants]
    term.romance_cognates = params[:romance_cognates]
    term.italic_cognates = params[:italic_cognates]
    term.etruscan = params[:etruscan]
    term.celtic_cognates = params[:celtic_cognates]
    term.germanic_cognates = params[:germanic_cognates]
    term.baltoslavic_cognates = params[:baltoslavic_cognates]
    term.albanian_cognates = params[:albanian_cognates]
    term.hellenic_cognates = params[:hellenic_cognates]
    term.armenian_cognates = params[:armenian_cognates]
    term.indoiranian_cognates = params[:indoiranian_cognates]
    term.semitic = params[:semitic]
    term.ie_cognates = params[:ie_cognates]
    term.notes1 = params[:notes1]
    term.notes2 = params[:notes2]
    term.quote = params[:quote]
    term.slug = params[:slug]

    if term.save
      flash[:success] = "Entry successfully updated"
      redirect_to "/pens"
    else
      flash[:warning] = "Entry was not saved. Please try again."
      render "edit.html.erb"
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
    @terms = Term.search(params[:query]).page(params[:page])
  end

end
