# frozen_string_literal: true

# Initialize one persistent connection to be shared between threads.
# Use typhoeus for parallel requests support.
ElasticsearchClient = Elasticsearch::Client.new(
  host: "https://elastic:#{Rails.application.credentials.elastic.password!}@localhost:9200",
  transport_options: { ssl: { verify: false } },
  ca_fingerprint: Rails.application.credentials.elastic.cert_fingerprint!
)
