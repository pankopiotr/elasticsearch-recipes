# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Recipes', type: :request do
  describe 'GET /recipes' do
    context 'when no parameter is provided' do
      it 'returns http success' do
        get('/recipes')
        expect(response).to have_http_status(:success)
        expect(response.body).to include('No recipes found for provided ingredients')
      end
    end

    context 'when query parameter is provided' do
      context 'when results are found' do
        it 'returns http success and renders matched recipes' do
          elasticsearch_result = {
            'took' => 12,
            'timed_out' => false,
            '_shards' => { 'total' => 1, 'successful' => 1, 'skipped' => 0, 'failed' => 0 },
            'hits' => {
              'total' => { 'value' => 3367, 'relation' => 'eq' },
              'max_score' => nil,
              'hits' => [
                {
                  '_index' => 'recipes',
                  '_id' => '26390',
                  '_score' => 7.2416625,
                  'fields' =>
                    { 'ratings' => [4.81],
                      'ingredients' =>
                      ['5 cups peeled and sliced apples',
                       '¼ cup brown sugar',
                       '¾ teaspoon ground cinnamon',
                       '¾ cup all-purpose flour'],
                      'title' => ['Perfect Apple Crisp Pie'] },
                  'sort' => [7.2416625, 4.8100000000000005]
                }
              ]
            }
          }
          # Ideally I would stub the request, instead of gem interface,
          # but it seems like overkill to add webmock/vhs, at least for now
          allow(ElasticsearchClient).to receive(:search).and_return(elasticsearch_result)

          parameters = { query: 'flour, brown sugar' }
          get('/recipes', params: parameters)
          expect(response).to have_http_status(:success)
          expect(response.body).to include('Perfect Apple Crisp Pie')
        end
      end

      context 'when no results are found' do
        it 'returns http success' do
          elasticsearch_result = {
            'took' => 4,
            'timed_out' => false,
            '_shards' => { 'total' => 1, 'successful' => 1, 'skipped' => 0, 'failed' => 0 },
            'hits' => {
              'total' => { 'value' => 0, 'relation' => 'eq' },
              'max_score' => nil,
              'hits' => []
            }
          }
          allow(ElasticsearchClient).to receive(:search).and_return(elasticsearch_result)

          parameters = { query: 'flour, brown sugar' }
          get('/recipes', params: parameters)
          get('/recipes')
          expect(response).to have_http_status(:success)
          expect(response.body).to include('No recipes found for provided ingredients')
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
