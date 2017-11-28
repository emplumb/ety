require 'elasticsearch/model'

class Term < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :user
  before_save :get_valid_slug, if: ->{ name_updated? }
  before_save :update_prefix, if: ->{ slug_updated? }

  def slug_updated?
    self.slug_changed? || self.new_record?
  end

  def name_updated?
    self.name_changed? || self.new_record?
  end

  def to_param
    slug
  end

  def ordered_attributes
    [name, gender, p_s, part_of_speech, definition, etymology1, etymology2, uses, variants, romance_cognates, italic_cognates, etruscan, celtic_cognates, germanic_cognates, baltoslavic_cognates, albanian_cognates, hellenic_cognates, armenian_cognates, indoiranian_cognates, semitic, uralic, ne_caucasian, ie_cognates, notes1, notes2]
  end

  def ordered_cognates
    ordered_attributes.select.with_index { |x, i| i > 7 && i < 23 }
  end

  def labels_and_attributes
    ATTRIBUTE_CONSTANTS.zip(ordered_attributes)
  end

  def labels_and_cognates
    COGNATE_CONSTANTS.zip(ordered_cognates)
  end

  ATTRIBUTE_CONSTANTS = %w(Name Gender Prefix/Suffix Part\ of\ Speech Definition Etymology\ 1 Etymology\ 2 Uses Variants Romance Italic Etruscan Celtic Germanic Balto-Slavic Albanian Hellenic Armenian Indo-Iranian Semitic Uralic Northeast\ Caucasian Indo-European Notes\ 1 Notes\ 2)

  COGNATE_CONSTANTS = ATTRIBUTE_CONSTANTS[8..22]
  
  MULTI_PREFIX = ['ch', 'll']
  ENYE_PREFIX = ['ñ']

  ALPHABET_CONSTANTS = %w(A B C CH D E F G H I J K L LL M N Ñ O P Q R S T U V W X Y Z)

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
        definition_analyzer: {
          tokenizer: 'standard',
          filter: ['lowercase', 'english_stemmer', 'spanish_stemmer', 'definition_stop'],
          char_filter: ['html_strip', 'accents_char_filter']
        }
      }
    } do

    mappings dynamic: 'false' do
      indexes :id, index: :no
      indexes :slug, analyzer: :spanish_analyzer, index_options: :offsets, store: true
      indexes :name, analyzer: :spanish_analyzer, index_options: :offsets, store: true
      indexes :p_s, index: :no
      indexes :part_of_speech, index: :no
      indexes :definition, analyzer: :definition_analyzer, index_options: :offsets, store: true
      indexes :etymology1, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :etymology2, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :variants, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :romance_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :italic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :etruscan, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :celtic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :germanic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :baltoslavic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :albanian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :hellenic_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :armenian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :indoiranian_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :semitic, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :uralic, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :ne_caucasian, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :ie_cognates, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :uses, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :notes1, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :notes2, analyzer: :combined_analyzer, index_options: :offsets, store: true
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['slug^20','name^15', 'definition^8', 'etymology1^7', 'etymology2^6', 'uses^4', 'variants^4', 'romance_cognates^5', 'italic_cognates^3', 'etruscan^3', 'celtic_cognates^3', 'germanic_cognates^3', 'baltoslavic_cognates^3', 'albanian_cognates^3', 'hellenic_cognates^3', 'armenian_cognates^3', 'indoiranian_cognates^3', 'semitic^3', 'uralic^3', 'ne_caucasian^3', 'ie_cognates^3', 'notes1^2', 'notes2^1'],
            operator: 'AND'
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          number_of_fragments: 0,
          fields: {
            name: {},
            definition: {},
            etymology1: {},
            etymology2: {},
            variants: {},
            uses: {},
            romance_cognates: {},
            italic_cognates: {},
            etruscan: {},
            celtic_cognates: {},
            germanic_cognates: {},
            baltoslavic_cognates: {},
            albanian_cognates: {},
            hellenic_cognates: {},
            armenian_cognates: {},
            indoiranian_cognates: {},
            semitic: {},
            uralic: {},
            ne_caucasian: {},
            ie_cognates: {},
            notes1: {},
            notes2: {}
          }
        }
      }
    )
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



