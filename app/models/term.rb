require 'elasticsearch/model'

class Term < ActiveRecord::Base
  belongs_to :user
  has_many :citations
  has_many :sources, through: :citations

  validates :name, presence: true

  before_save :get_valid_slug, if: ->{ name_updated? }
  before_save :update_prefix, if: ->{ slug_updated? }

  MULTI_PREFIX = ['ch', 'll']
  ENYE_PREFIX = ['ñ']

  LOWERCASE_ALPHABET_CONSTANTS = %w(a b c ch d e f g h i j k l ll m n ñ o p q r s t u v w x y z)
  UPPERCASE_ALPHABET_CONSTANTS = %w(A B C CH D E F G H I J K L LL M N Ñ O P Q R S T U V W X Y Z)

  def slug_updated?
    self.slug_changed? || self.new_record?
  end

  def name_updated?
    self.name_changed? || self.new_record?
  end

  def to_param
    slug
  end

  def ie_c
    indo_european_cognates
  end

  def u_c
    uralic_cognates
  end

  def nec_c
    northeast_caucasian_cognates
  end

  def aa_c
    afro_asiatic_cognates
  end

  private
    def get_valid_slug
      param_name = name.parameterize
      count = 1

      if Term.exists?(['slug LIKE ?', "#{param_name}"])
        count += 1
        self.slug = "#{param_name}-#{count}"

        while Term.exists?(['slug LIKE ?', "#{param_name}-#{count}"])
          count += 1
          self.slug = "#{param_name}-#{count}"
        end
      else
        self.slug = param_name
      end
    end

    def update_prefix
      self.prefix = MULTI_PREFIX.detect do |multi|
        self.slug.start_with?(multi)
      end || self.prefix = ENYE_PREFIX.detect do |enye|
        self.name.start_with?(enye)
      end || self.slug[0]
    end

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 5, number_of_replicas: 1 },
    analysis: {
      filter: {
        english_stop: {
          type: 'stop',
          stopwords: ['i', 'u', 'and', 'the', 'in', 'on', 'or', 'to', 'a', 'an', 'of', 'that', 'have', 'it', 'is', 'are', 'for', 'not', 'with', 'as', 'do', 'not', 'at', 'this', 'but', 'by', 'from', 'will', 'would', 'there', 'what', 'so', 'if', 'when', 'can', 'no', 'into', 'some', 'than', 'then', 'only', 'its', 'also', 'back', 'after', 'use', 'two', 'how', 'where', 'first', 'because', 'any', 'these', 'most', 'all', 'why', 'who', 'see', 'dates', 'same', 'meaning', 'indicate', 'indicating', 'f', 'm', 'suffix', 'prefix', 'noun', 'verb', 'adjective', 'adverb', 'pronoun', 'interjection', 'preposition', 'called']
        },
        english_stemmer: {
          type: 'stemmer',
          name: 'porter2'
        },
        spanish_stop: {
          type: 'stop',
          stopwords: ['el', 'él', 'la', 'que', 'qué', 'de', 'y', 'en', 'un', 'se', 'ser', 'haber', 'por', 'con', 'su', 'para', 'como', 'estar', 'tener', 'le', 'lo', 'todo', 'pero', 'mas', 'más', 'hacer', 'o', 'poder', 'este', 'ir', 'ese', 'si', 'me', 'ya', 'ver' 'porque', 'dar', 'cuando', 'muy', 'sin', 'mucho', 'mi', 'alguno', 'desde', 'eso', 'nos', 'sí', 'uno', 'una', 'bien', 'entonces', 'donde', 'yo', 'también', 'e', 'del', 'a']
        },
        spanish_stemmer: {
          type: 'stemmer',
          name: 'spanish'
        },
        light_spanish_stemmer: {
          type: 'stemmer',
          name: 'light_spanish'
        },
        definition_stop: {
          type: 'stop',
          stopwords: ['and', 'or', 'a', 'to', 'an']
        }
      },
      char_filter: {
        accents_char_filter: {
          type: 'mapping',
          mappings: [
            'ñ => n',
            'á => a',
            'é => e',
            'í => i',
            'ó => o',
            'ú => u',
            'ü => u',
          ]
        }
      },
      analyzer: {
        combined_analyzer: {
          tokenizer: 'standard',
          filter: ['lowercase', 'english_stop', 'english_stemmer', 'spanish_stop', 'spanish_stemmer'],
          char_filter: ['html_strip', 'accents_char_filter']
        },
        spanish_analyzer: {
          tokenizer: 'classic',
          filter: ['lowercase', 'spanish_stemmer'],
          char_filter: ['html_strip', 'accents_char_filter']
        },
        name_analyzer: {
          tokenizer: 'classic',
          filter: ['lowercase', 'light_spanish_stemmer'],
          char_filter: ['html_strip', 'accents_char_filter']
        },
        definition_analyzer: {
          tokenizer: 'standard',
          filter: ['lowercase', 'english_stemmer', 'spanish_stemmer', 'definition_stop'],
          char_filter: ['html_strip', 'accents_char_filter']
        }
      }
    } do

    mappings dynamic: 'false' do
      indexes :slug, analyzer: :spanish_analyzer, index_options: :offsets, store: true
      indexes :name, analyzer: :name_analyzer, index_options: :offsets, store: true
      indexes :definition, analyzer: :definition_analyzer, index_options: :offsets, store: true
      indexes :etymology1, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :etymology2, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :variants, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :indo_european_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :romance_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :italic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :celtic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :germanic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :albanian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :balto_slavic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :hellenic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :thracian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :phrygian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :messapian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :armenian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :indo_iranian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :tocharian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :anatolian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :basque_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :tyrsenian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :uralic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :sami_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :finnic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :mordvinic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :mari_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :mansi_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :khanty_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :northeast_caucasian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :nakh_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :lezgic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :dargwa_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :lak_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :lezghian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :afro_asiatic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :egyptian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :semitic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :notes1, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :notes2, analyzer: :combined_analyzer, index_options: :offsets, store: true
    end
  end

  def self.search(query)
    __elasticsearch__.search({
      query: {
        multi_match: {
          query: query,
          fields: ['slug^10','name^50', 'definition^15', 'etymology1^7', 'etymology2^6', 'uses^4', 'variants^3', 'indo_european_cognates^3', 'romance_cognates^3', 'italic_cognates^3', 'celtic_cognates^3', 'germanic_cognates^3', 'albanian_cognates^3', 'balto_slavic_cognates^3', 'hellenic_cognates^3', 'thracian_cognates^3', 'phrygian_cognates^3', 'messapian_cognates^3', 'armenian_cognates^3', 'indo_iranian_cognates^3', 'tocharian_cognates^3', 'anatolian_cognates^3', 'basque_cognates^3', 'tyrsenian_cognates^3', 'uralic_cognates^3', 'sami_cognates^3', 'finnic_cognates^3', 'mordvinic_cognates^3', 'mari_cognates^3', 'mansi_cognates^3', 'khanty_cognates^3', 'northeast_caucasian_cognates^3', 'nakh_cognates^3', 'lezgic_cognates^3', 'dargwa_cognates^3', 'lak_cognates^3', 'lezghian_cognates^3', 'afro_asiatic_cognates^3', 'egyptian_cognates^3', 'semitic_cognates^3', 'notes1^2', 'notes2^1'],
          operator: 'AND'
        }
      },
      sort: [
        { _score: {order: 'desc'} },
        { name: {order: 'asc'} }
      ],
      highlight: {
        pre_tags: ['<em>'],
        post_tags: ['</em>'],
        number_of_fragments: 0,
        fields: {
          name: {},
          definition: {},
          etymology1: {},
          etymology2: {},
          uses: {},
          variants: {},
          indo_european_cognates: {},
          romance_cognates: {},
          italic_cognates: {},
          celtic_cognates: {},
          germanic_cognates: {},
          albanian_cognates: {},
          balto_slavic_cognates: {},
          hellenic_cognates: {},
          thracian_cognates: {},
          phrygian_cognates: {},
          messapian_cognates: {},
          armenian_cognates: {},
          indo_iranian_cognates: {},
          tocharian_cognates: {},
          anatolian_cognates: {},
          basque_cognates: {},
          tyrsenian_cognates: {},
          uralic_cognates: {},
          sami_cognates: {},
          finnic_cognates: {},
          mordvinic_cognates: {},
          mari_cognates: {},
          mansi_cognates: {},
          khanty_cognates: {},
          northeast_caucasian_cognates: {},
          nakh_cognates: {},
          lezgic_cognates: {},
          dargwa_cognates: {},
          lak_cognates: {},
          lezghian_cognates: {},
          afro_asiatic_cognates: {},
          egyptian_cognates: {},
          semitic_cognates: {},
          notes1: {},
          notes2: {}
        }
      }
    })
  end
end

# Delete the previous term index in Elasticsearch
Term.__elasticsearch__.client.indices.delete index: Term.index_name rescue nil

# Create the new index with the new mapping
Term.__elasticsearch__.client.indices.create \
  index: Term.index_name,
  body: { settings: Term.settings.to_hash, mappings: Term.mappings.to_hash }

# Index all term records from the DB to Elasticsearch
Term.import(force: true)



