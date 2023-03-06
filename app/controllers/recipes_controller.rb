# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    return if params[:query].blank?

    ingredients = params[:query].split(',').map(&:strip)
    query = ingredients.map { |ingredient| { match_phrase: { ingredients: ingredient } } }
    body = { query: { bool: { should: query } },
             fields: %w[title ingredients ratings],
             _source: false,
             sort: ['_score', { ratings: 'desc' }],
             size: 10 }
    result = ElasticsearchClient.search(index: 'recipes', body:)
    @recipes_hashes = result.dig('hits', 'hits').pluck('fields').map(&:deep_symbolize_keys)
  end
end
