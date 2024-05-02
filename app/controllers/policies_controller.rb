class PoliciesController < ApplicationController
  def index
    @policies = JSON.parse(build_request(query_policies).body)['data']['policies']
  end

  def new; end

  def create
    build_request(mutation_policy)
    flash[:success] = 'Policy created'
    redirect_to root_path
  end

  private

  def build_request(graphql_query)
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

  def mutation_policy
    <<-GRAPHQL
      mutation {
        createPolicy(
          emissionDate: #{params[:emission_date]},
          endDateCoverage: #{params[:end_date_coverage]},
          vehicle: {
            brand: #{params[:vehicle_brand]},
            licensePlate: #{params[:vehicle_lisence_plate]},
            model: #{params[:vehicle_model]},
            year: #{params[:vehicle_year]}
          },
          insured: {
            name: #{params[:insured_name]},
            cpf: #{params[:insured_cpf]}
          }
        )
      }
    GRAPHQL
  end

  def query_policies
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
