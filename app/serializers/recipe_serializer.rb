# frozen_string_literal: true

# Might be an overkill to add serializer just for the purpose of loading data into elasticsearch.
class RecipeSerializer
  include JSONAPI::Serializer

  attributes :id, :ingredients, :ratings, :title
end
