require 'rails_helper'

describe "Items Revenue API endpoints" do
  it "sends a list of items with the highest total revenue" do
    create_list(:item, 20)
    get '/api/v1/revenue/items?/quantity=10'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to be_a(Hash)
    expect(items[:data]).to be_an(Array)

    items[:data].each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    end
  end
end