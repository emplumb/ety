require 'elasticsearch/model'

class Term < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # settings index: { number_of_shards: 1, number_of_replicas: 0 },
  #   analysis: {
  #     filter: {
  #       synonym: {
  #         type: "synonym",
  #         synonyms_path: "synonyms.txt",
  #         ignore_case: "true"
  #       }
  #     },
  #     analyzer: {
  #       synonym: {
  #         tokenizer: "whitespace",
  #         filter: ["synonym"]
  #       }
  #     }
  #   } do


  #   mappings dynamic: 'false' do
  #     indexes :id, index: :not_analyzed
  #     indexes :name, analyzer: 'spanish', analyzer: 'synonym'
  #     indexes :gender, index: :not_analyzed
  #     indexes :part_of_speech, index: :not_analyzed
  #     indexes :definition, analyzer: 'synonym'
  #     indexes :etymology1, analyzer: 'synonym'
  #     indexes :etymology2, analyzer: 'synonym'
  #     indexes :uses, analyzer: 'synonym'
  #     indexes :romance_cognates, analyzer: 'synonym'
  #     indexes :notes1, analyzer: 'synonym'
  #     indexes :notes2, analyzer: 'synonym'
  #     indexes :quote1, analyzer: 'spanish', analyzer: 'synonym'
  #     indexes :quote2, analyzer: 'spanish', analyzer: 'synonym'
  #   end
  # end

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
            fields: ['name', 'definition', 'etymology1', 'etymology2', 'uses', 'romance_cognates', 'notes1', 'notes2', 'quote1', 'quote2']
          }
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

  # @results = Elasticsearch::Model.search(query, [Term]).results
  # response = Term.search(:query)

end

# Delete the previous terms index in Elasticsearch
# Term.__elasticsearch__.client.indices.delete index: Term.index_name rescue nil

# Create the new index with the new mapping
# Term.__elasticsearch__.client.indices.create \
#   index: Term.index_name,
#   body: { settings: Term.settings.to_hash, mappings: Term.mappings.to_hash }

# Index all term records from the db to Elasticsearch
Term.import(force: true)



# response = Term.search :query

# require 'elasticsearch/rails/tasks/import'
