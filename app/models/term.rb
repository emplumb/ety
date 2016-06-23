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
        spanish_stop: {
          type: 'stop',
          stopwords: '_spanish_'
        },
        my_stop: {
          type: 'stop',
          # stopwords: ['and', 'the', 'in', 'on', 'or', 'to', 'a', 'an', 'of', 'that', 'have', 'it', 'is', 'for', 'not', 'with', 'as', 'do', 'not', 'at', 'this', 'but', 'by', 'from', 'will', 'would', 'there', 'what', 'so', 'if', 'when', 'can', 'no', 'into', 'some', 'than', 'then', 'only', 'its', 'also', 'back', 'after', 'use', 'two', 'how', 'where', 'first', 'because', 'any', 'these', 'most', 'el', 'él', 'la', 'que', 'qué', 'de', 'y', 'en', 'un', 'se', 'por', 'con', 'su', 'para', 'como', 'le', 'lo', 'pero', 'mas', 'más', 'o', 'ir', 'ese', 'si', 'me', 'ya', 'porque', 'muy', 'mucho', 'mi', 'yo', 'también']
          stopwords: 'él'
        }
      },
        # synonym: {
        #   type: 'synonym',
        #   synonyms_path: 'synonyms.txt',
        #   ignore_case: 'true'
        # },
      #   spanish_stemmer: {
      #     type: 'stemmer',
      #     language: 'light_spanish'
      #   }
      # },
      analyzer: {
        my_analyzer: {
          tokenizer: 'standard',
          filter: 'my_stop',
          # char_filter: 'html_strip',
          type: 'stop'
        }

      # analyzer: {
      #   stops_and_synonyms: {
      #     type: 'custom',
      #     tokenizer: 'standard',
      #     stopwords: ["and", "the", "in", "on", "or", "to", "a", "an", "of", "that", "have", "it", "is", "for", "not", "with", "as", "do", "not", "at", "this", "but", "by", "from", "will", "would", "there", "what", "so", "if", "when", "can", "no", "into", "some", "than", "then", "only", "its", "also", "back", "after", "use", "two", "how", "where", "first", "because", "any", "these", "most"],
      #     char_filter: 'html_strip',
      #     filter: [
      #       'spanish_stop',
      #       'spanish_stemmer',
      #       # 'synonym',
      #       'lowercase'
      #     ]
      #   },
        # spanish: {
        #   tokenizer: 'standard',
        #   # filter: 'synonym',
        #   language: 'spanish'
        # }
      }
    } do

    mappings dynamic: 'false' do
      indexes :id, index: :not_analyzed
      indexes :name, analyzer: :my_analyzer, index_options: 'offsets'
      indexes :p_s, analyzer: :my_analyzer, index: :not_analyzed
      indexes :gender, analyzer: :my_analyzer, index: :not_analyzed
      indexes :part_of_speech, analyzer: :my_analyzer, index: :not_analyzed
      indexes :definition, analyzer: :my_analyzer, index_options: 'offsets'
      indexes :etymology1, analyzer: :my_analyzer, index_options: 'offsets'
      indexes :etymology2, analyzer: :my_analyzer, index_options: 'offsets'
      indexes :uses, analyzer: :my_analyzer, index_options: 'offsets'
      indexes :notes1, analyzer: :my_analyzer, index_options: 'offsets'
      indexes :notes2, analyzer: :my_analyzer, index_options: 'offsets'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^7', 'definition^6', 'etymology1^5', 'etymology2^4', 'uses^3', 'notes1^2', 'notes2^1']
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


