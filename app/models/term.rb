require 'elasticsearch/model'

class Term < ActiveRecord::Base
  validates :name, presence: true

  before_save :update_slug, :update_prefix

  def update_slug
    pname = name.parameterize
    self.slug = get_valid_slug(pname, 1)
  end

  private
    def get_valid_slug(name, index)
      index_name = index > 1 ? name + "-" + index.to_s : name

      if Term.exists?(slug: index_name)
        return get_valid_slug(name, index + 1)
      end

      return index_name
    end

  def to_param
    slug
  end

  MULTI_PREFIX = ['ch', 'll']
  ENYE_PREFIX = ['ñ']

  private
    def update_prefix
      self.prefix = MULTI_PREFIX.detect do |multi|
        self.slug.start_with?(multi)
      end || self.prefix = ENYE_PREFIX.detect do |enye|
        self.name.start_with?(enye)
      end || self.slug[0]
    end

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1, number_of_replicas: 0 },
    analysis: {
      filter: {
        english_stop: {
          type: 'stop',
          stopwords: ['and', 'the', 'in', 'on', 'or', 'to', 'a', 'an', 'of', 'that', 'have', 'it', 'is', 'for', 'not', 'with', 'as', 'do', 'not', 'at', 'this', 'but', 'by', 'from', 'will', 'would', 'there', 'what', 'so', 'if', 'when', 'can', 'no', 'into', 'some', 'than', 'then', 'only', 'its', 'also', 'back', 'after', 'use', 'two', 'how', 'where', 'first', 'because', 'any', 'these', 'most', 'all', 'why', 'who', 'see', 'dates', 'same', 'meaning', 'indicate', 'indicating', 'f', 'm', 'suffix', 'prefix', 'noun', 'verb', 'adjective', 'adverb', 'pronoun', 'interjection', 'preposition']
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
      indexes :id, index: :no
      indexes :name, analyzer: :spanish_analyzer, index_options: :offsets, store: true
      indexes :p_s, index: :no
      indexes :gender, index: :no
      indexes :part_of_speech, index: :no
      indexes :definition, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :etymology1, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :etymology2, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :uses, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :notes1, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :notes2, analyzer: :combined_analyzer, index_options: :offsets, store: true
      indexes :slug, analyzer: :spanish_analyzer
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
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          number_of_fragments: 0,
          fields: {
            definition: {},
            etymology1: {},
            etymology2: {},
            uses: {},
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



