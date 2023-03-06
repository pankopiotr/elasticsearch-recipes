# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeSerializer, type: :serializer do # rubocop:disable Metrics/BlockLength
  let(:recipe) do
    Recipe.new(
      id: 123_456_789,
      title: 'Golden Sweet Cornbread',
      cook_time: 25,
      prep_time: 10,
      ingredients: ['1 cup all-purpose flour', '1 cup yellow cornmeal', '⅔ cup white sugar', '1 teaspoon salt',
                    '3 ½ teaspoons baking powder', '1 egg', '1 cup milk', '⅓ cup vegetable oil'],
      ratings: 4.74,
      cuisine: 'none',
      category: 'Cornbread',
      author: 'bluegirl',
      image: 'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2021%2F10%2F26%2Fcornbread-1.jpg',
      created_at: Time.parse('Wed, 01 Mar 2023 19:07:26.602255000 UTC +00:00'),
      updated_at: Time.parse('Wed, 01 Mar 2023 19:07:26.602255000 UTC +00:00')
    )
  end
  let(:expected_result) do
    {
      data: {
        attributes: {
          id: 123_456_789,
          ingredients: ['1 cup all-purpose flour', '1 cup yellow cornmeal', '⅔ cup white sugar', '1 teaspoon salt',
                        '3 ½ teaspoons baking powder', '1 egg', '1 cup milk', '⅓ cup vegetable oil'],
          ratings: BigDecimal('4.74'),
          title: 'Golden Sweet Cornbread'
        },
        id: '123456789',
        type: :recipe
      }
    }
  end

  describe '#serializable_hash' do
    it 'serializes recipe to a hash' do
      result = described_class.new(recipe).serializable_hash

      expect(result).to eq(expected_result)
    end
  end
end
