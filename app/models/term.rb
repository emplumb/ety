require 'elasticsearch/model'

class Term < ActiveRecord::Base
  validates :name, presence: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def slug_candidates
    [
      :name,
      [:name, "2"]
    ]
  end

  MULTI_TERM_PREFIX = ['ch', 'll']
  before_validation :update_prefix, if: :name_changed?

  private
    def update_prefix
      self.prefix = MULTI_TERM_PREFIX.detect do |prefix|
        self.name.downcase.start_with?(prefix)
      end || self.name[0].downcase
    end

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1, number_of_replicas: 0 },
    analysis: {
      filter: {
        english_stop: {
          type: 'stop',
          stopwords: ['and', 'the', 'in', 'on', 'or', 'to', 'a', 'an', 'of', 'that', 'have', 'it', 'is', 'for', 'not', 'with', 'as', 'do', 'not', 'at', 'this', 'but', 'by', 'from', 'will', 'would', 'there', 'what', 'so', 'if', 'when', 'can', 'no', 'into', 'some', 'than', 'then', 'only', 'its', 'also', 'back', 'after', 'use', 'two', 'how', 'where', 'first', 'because', 'any', 'these', 'most', 'all', 'why', 'who', 'see', 'dates', 'same', 'meaning', 'indicate', 'indicating']
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
          name: 'light_spanish'
        }
      },
      analyzer: {
        combined_analyzer: {
          tokenizer: 'standard',
          filter: ['lowercase', 'english_stop', 'english_stemmer', 'spanish_stop', 'spanish_stemmer'],
          char_filter: 'html_strip'
        },
        spanish_analyzer: {
          tokenizer: 'standard',
          filter: ['lowercase', 'spanish_stemmer']
        }
      }
    } do

    mappings dynamic: 'false' do
      indexes :id, index: :not_analyzed
      indexes :name, analyzer: :spanish_analyzer
      indexes :p_s, index: :no
      indexes :gender, index: :no
      indexes :part_of_speech, index: :no
      indexes :definition, analyzer: :combined_analyzer
      indexes :etymology1, analyzer: :combined_analyzer
      indexes :etymology2, analyzer: :combined_analyzer
      indexes :uses, analyzer: :combined_analyzer
      indexes :notes1, analyzer: :combined_analyzer
      indexes :notes2, analyzer: :combined_analyzer
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^7', 'definition^6', 'etymology1^5', 'etymology2^4', 'uses^3', 'notes1^2', 'notes2^1'],
            operator: 'and'
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


