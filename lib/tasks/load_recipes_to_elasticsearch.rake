# frozen_string_literal: true

desc 'Load recipes in JSON format from recipes-en.json to database as Recipes'
task load_recipes_to_elasticsearch: :environment do
  index_name = Rails.application.credentials.elastic.recipes_index_name
  Recipe.find_in_batches do |batch_of_recipes|
    body = batch_of_recipes.map do |recipe|
      {
        index: {
          _index: index_name,
          _id: recipe.id,
          data: RecipeSerializer.new(recipe).serializable_hash.dig(:data, :attributes)
        }
      }
    end
    ElasticsearchClient.bulk(index: index_name, body:)
  end
end
