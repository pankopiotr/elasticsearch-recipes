# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.string :ingredients, array: true
      t.decimal :ratings, precision: 3, scale: 2
      t.string :cuisine
      t.string :category
      t.string :author
      t.text :image

      t.timestamps
    end
  end
end
