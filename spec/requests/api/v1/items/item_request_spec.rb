require 'rails_helper'

describe "Item API endpoints" do
  it "can get one item by its id" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)

    get "/api/v1/items/#{item_1.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes]).to have_key(:id)
    expect(item[:data][:attributes][:id]).to be_an(Integer)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
  end

  it 'sends error code if item does not exist' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)

    get "/api/v1/items/100"

    expect(response.status).to eq(404)
  end
end