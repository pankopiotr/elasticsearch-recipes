# Description
Application that helps users find the most relevant recipes that they can prepare with the ingredients that they have at home.

# Stack:
* Ruby 3.2.1
* Rails 7.0.4.2
* PostgreSQL 15.2.1
* Elasticsearch 8.6.2

# Elasticsearch setup:
1. [Install elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) or create a docker container with it.

    I installed it locally. You should be able to use dockerized one without any modification to the code (*I did not test it). In case of remote cluster, you may need to change the way connection is configured.
1. Start elasticsearch or  the docker container.
2. Find or regenerate elastic user password and save it.
    1. For local installation: Go to elastic installation directory and run `bin/elasticsearch-reset-password -u elastic`.
    2. For docker look [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-dev-mode) (point 3).
2. Find or regenerate certification fingerprint and save it.
    1. For local installation: Run `openssl x509 -fingerprint -sha256 -noout -in /path/to/cert/http_ca.crt`. On my intel mac it is placed in *elasticsearch/config/certs/http_ca.crt*.
    2. For docker look [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-dev-mode) (point 4). Use the copied file to generate fingerprint using command from subpoint 1.

# Application setup:
Complete Elasticsearch setup first.

1. Create config/master.key file with contents `908a8e6193d8d07d94882079313d6b88`.
2. Edit credentials file with password from elasticsearch setup step 2. and fingerprint from step 3. by running `rails credentials:edit`.
3. Setup database by running `rails db:setup`.
4. Run migrations with `rails db:migrate`.
5. Seed database with `rails db:seed`.
6. Run tests with `bundle exec rspec`.
7. Run rubocop with `bundle exec rubocop`.
8. Run rake task to setup elasticsearch index and mappings with `rails setup_elasticsearch_indexes_and_mappings`.
9. Load recipes from database to elasticsearch `rails load_recipes_to_elasticsearch`.
10. Start server `rails s`

# Notes

If you are interesed in commit history, please check the first commit in the repository for more information.
