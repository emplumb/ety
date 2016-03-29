require 'elasticsearch/model'

class Term < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1, number_of_replicas: 0 },

    analysis: {
      filter: {
        english_stop: {
          type: "stop",
          stopwords: ["_english_"]
          #text file created in config folder in case I want to use my own custom instead
          #       stopwords: ["and", "the", "in", "on", "or", "to", "a", "an" "of", "that", "have", "it", "is", "for", "not", "with", "as", "do", "not", "at", "this", "but", "by", "from", "will", "would", "there", "what", "so", "if", "when", "can", "no", "into", "some", "than", "then", "only", "its", "also", "back", "after", "use", "two", "how", "where", "first", "because", "any", "these", "most"]
        },
        spanish_stop: {
          type: "stop",
          stopwords: ["_spanish_"]
        },
        spanish_stemmer: {
          type: "stemmer",
          language: "light_spanish"
        },
        synonym: {
          type: "synonym",
          synonyms_path: "synonyms.txt",
          ignore_case: "true"
        }
      },
      analyzer: {
        stops_and_synonyms: {
          type: "custom",
          # tokenizer: "whitespace",
          tokenizer: "standard",
          filter: [
            "english_stop",
            "spanish_stop",
            "synonym",
            "lowercase"
          ]
        },
        spanish: {
          tokenizer: "standard",
          filter: "synonym"
        }
      }
    } do

    mappings dynamic: 'false' do
      indexes :id, index: :not_analyzed
      indexes :name, analyzer: 'spanish', index_options: 'offsets'
      indexes :gender, index: :not_analyzed
      indexes :part_of_speech, index: :not_analyzed
      indexes :definition, index_options: 'offsets'
      indexes :etymology1, analyzer: 'stops_and_synonyms', index_options: 'offsets'
      indexes :etymology2, analyzer: 'stops_and_synonyms', index_options: 'offsets'
      indexes :uses, analyzer: 'stops_and_synonyms', index_options: 'offsets'
      indexes :romance_cognates, analyzer: 'stops_and_synonyms', index_options: 'offsets'
      indexes :notes1, analyzer: 'stops_and_synonyms', index_options: 'offsets'
      indexes :notes2, analyzer: 'stops_and_synonyms', index_options: 'offsets'
      indexes :quote1, analyzer: 'stops_and_synonyms', index_options: 'offsets'
      indexes :quote2, analyzer: 'stops_and_synonyms', index_options: 'offsets'
    end
  end

  # def as_indexed_json(options = {})
  #   as_json(
  #     only: [:name, :gender, :part_of_speech, :definition, :etymology1, :etymology2, :uses, :romance_cognates, :notes1, :notes2, :quote1, :quote2]
  #   )
  # end

  def self.search(query)
    __elasticsearch__.search(
       {
        query: {
          multi_match: {
            query: query,
            fields: ['name^10', 'definition^9', 'etymology1', 'etymology2', 'uses', 'romance_cognates', 'notes1', 'notes2', 'quote1', 'quote2'],
            operator: 'and',
            cutoff_frequency: 0.001
          }
          # match: {
          #   notes1: {
          #     query: query,
          #     cutoff_frequency: 0.001
          #   }
          # }
          # common: {
          #   body: {
          #     query: query,
          #     cutoff_frequency: 0.001
          #   }
          # }
          # match: {
          #   common: {
          #     notes1: {
          #       query: query,
          #       cutoff_frequency: 0.001
          #     }
          #   }
          # }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            name: {},
            definition: {},
            etymology1: {},
            etymology2: {},
            uses: {},
            romance_cognates: {},
            notes1: {},
            notes2: {},
            quote1: {},
            quote2: {}
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


