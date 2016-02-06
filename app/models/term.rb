require 'elasticsearch/model'

class Term < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
Term.import(force: true)



#require 'elasticsearch/model'
# class Term < ActiveRecord::Base
#      # ElasticSearch
#   include Elasticsearch::Model
#   include Elasticsearch::Model::Callbacks

#   settings index: {
#     number_of_shards: 1,
#     analysis: {
#       filter: {
#         trigrams_filter: {
#           type: 'ngram',
#           min_gram: 2,
#           max_gram: 10
#         },
#         content_filter: {
#           type: 'ngram',
#           min_gram: 4,
#           max_gram: 20
#         }
#       },
#       analyzer: {
#         index_trigrams_analyzer: {
#           type: 'custom',
#           tokenizer: 'standard',
#           filter: ['lowercase', 'trigrams_filter']
#         },
#         search_trigrams_analyzer: {
#           type: 'custom',
#           tokenizer: 'whitespace',
#           filter: ['lowercase']
#         },
#         english: {
#           tokenizer: 'standard',
#           filter: ['standard', 'lowercase', 'content_filter']
#         }
#       }
#     }
#     } do
#     mappings dynamic: 'false' do
#       indexes :name, index_analyzer: 'index_trigrams_analyzer', search_analyzer: 'search_trigrams_analyzer'
#       indexes :definition, index_analyzer: 'english', search_analyzer: 'english'
#       indexes :etymology1, index_analyzer: 'english', search_analyzer: 'english'
#       indexes :romance_cognates, analyzer: 'snowball'
#     end
#   end



#   def self.search(query)
#     __elasticsearch__.search(
#       {
#         query: {
#           query_string: {
#             query: query,
#             fuzziness: 2,
#             default_operator: "AND",
#             fields: ['name^10', 'definition', 'etymology1', 'romance_cognates']
#           }
#         },
#         highlight: {
#           pre_tags: ['<em>'],
#           post_tags: ['</em>'],
#           fields: {
#             name: {},
#             definition: {}
#           }
#         }
#       }
#     )
#   end

#   def as_indexed_json(options={})
#     as_json(methods: [:etymology1, :romance_cognates])
#   end

#  end

# # Delete the previous Terms index in Elasticsearch
# Term.__elasticsearch__.client.indices.delete index: Term.index_name rescue nil

# # Create the new index with the new mapping
# Term.__elasticsearch__.client.indices.create \
#   index: Term.index_name,
#   body: { settings: Term.settings.to_hash, mappings: Term.mappings.to_hash }

# # Index all article records from the DB to Elasticsearch
# Term.import(force: true)
# end


# require 'elasticsearch/model'

# class Term < ActiveRecord::Base
#   include Elasticsearch::Model
#   include Elasticsearch::Model::Callbacks
# end

# Term.import(force: true)

# @terms = Term.search('foobar').records


# require 'elasticsearch/rails/tasks/import'

# class Term < ActiveRecord::Base
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks


  # mapping do
  #   indexes :id, index: :not_analyzed
  #   indexes :name
  #   indexes :gender
  #   indexes :part_of_speech
  #   indexes :definition
  #   indexes :etymology1
  #   indexes :etymology2
  #   indexes :uses
  #   indexes :romance_cognates
  #   indexes :notes1
  #   indexes :notes2
  #   indexes :quote1
  #   indexes :quote2
  # end

# end

