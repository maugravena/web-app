class PoliciesController < ApplicationController
  def index
    encoded_token = JWT.encode({}, ENV['SECRET_KEY'], 'HS256')

    url = URI.parse('http://rails-graphql:9999/graphql')
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Post.new(url.request_uri)
    request.body = { query: graphql_query }.to_json
    request['Authorization'] = encoded_token
    request['Content-Type'] = 'application/json'
    response = http.request(request)

    @policies = JSON.parse(response.body)['data']['policies']
  end

  private

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
