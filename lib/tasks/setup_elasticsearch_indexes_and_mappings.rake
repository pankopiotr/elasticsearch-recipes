# frozen_string_literal: true

desc 'Load recipes in JSON format from recipes-en.json to database as Recipes'
task setup_elasticsearch_indexes_and_mappings: :environment do
  index_name = Rails.application.credentials.elastic.recipes_index_name
  index_settings = { number_of_shards: 1, number_of_replicas: 0 }
  settings = { settings: { index: index_settings } }
  ElasticsearchClient.indices.create(index: index_name, body: settings)
  ElasticsearchClient.indices.put_mapping(index: index_name, body: MAPPINGS)
end

MAPPINGS = {
  dynamic: 'strict',
  properties: {
    id: { type: 'keyword' },
    title: { type: 'text' },
    # cook_time: { type: 'integer' },
    # prep_time: { type: 'integer' },
    ingredients: { type: 'text' },
    ratings: { type: 'scaled_float', scaling_factor: 100 },
    # cuisine: { type: 'keyword' },
    # author: { type: 'keyword' },
    # image: { type: 'keyword' }
  }
}.freeze
