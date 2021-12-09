require 'rails_helper'

describe "Find Items" do
  it "can find all items when searched for by name" do
    merchant_1 = create(:merchant)
    item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

    search = "pot"

    get "/api/v1/items/find_all?name=#{search}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can find one item when searched for by name" do
    merchant_1 = create(:merchant)
    item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

    search = "pot"
    get "/api/v1/items/find?name=#{search}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item).to be_a(Hash)
    expect(item).to have_key(:data)
    expect(item[:data].first[:attributes]).to have_key(:name)
    expect(item[:data].first[:attributes][:name]).to be_a(String)
  end
end