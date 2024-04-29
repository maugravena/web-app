class PoliciesController < ApplicationController
  def index
    @policies = JSON.parse(build_request.body)['data']['policies']
  end

  private

  def build_request
    url = URI.parse('http://rails-graphql:9999/graphql')
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url.request_uri, build_headers)
    request.body = { query: graphql_query }.to_json

    http.request(request)
  end

  def build_headers
    {
      'Authorization' => "Bearer #{encoded_token}",
      'Content-Type' => 'application/json'
    }
  end

  def encoded_token = JWT.encode({}, ENV['SECRET_KEY'], 'HS256')

  def graphql_query
    <<-GRAPHQL
      query {
        policies {
          policyId
          emissionDate
          endDateCoverage
          vehicle {
            brand
            model
            year
          }
          insured {
            name
            cpf
          }
        }
      }
    GRAPHQL
  end
end
