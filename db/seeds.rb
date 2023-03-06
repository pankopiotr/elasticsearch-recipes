# frozen_string_literal: true

# 10k records is still manageable to load all at once (at least on my machine).
# If there would be more, I would consider streaming the file to a parser such as Yajl::FFI or Oj:Sai
recipes_file = Rails.root.join('recipes-en.json').read
recipes = JSON.parse(recipes_file)

# File is static and has been checked so there's no need for validation and error handling
recipes.each_slice(500) { |batch_of_recipes| Recipe.insert_all(batch_of_recipes) } # rubocop:disable Rails/SkipsModelValidations
