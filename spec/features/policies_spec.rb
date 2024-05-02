require 'rails_helper'

RSpec.feature 'Policies', type: :feature do
  scenario 'Create a new policy' do
    stub_request(:post, 'http://rails-graphql:9999/graphql')
      .to_return(status: 200, body: { data: { policies: [] } }.to_json)

    visit new_policy_path

    fill_in 'CPF', with: '123.456.789-00'
    fill_in 'Name', with: 'John Doe'
    fill_in 'Emission date', with: '2024-04-20'
    fill_in 'End date coverage', with: '2025-04-20'
    fill_in 'Brand', with: 'Volkswagen'
    fill_in 'Model', with: 'Fusca'
    fill_in 'Year', with: '1977'
    fill_in 'License plate', with: 'ABC-1234'

    click_button 'Create'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Policy created'
  end
end
