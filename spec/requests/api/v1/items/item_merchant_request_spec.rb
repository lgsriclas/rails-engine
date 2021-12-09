require 'rails_helper'

describe "Item's Merchant API endpoint" do
  it "gets the merchant data for a given item" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)

    get "/api/v1/items/#{item_1.id}/merchant"

    expect(response).to be_successful

    item_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(item_merchant[:data][:attributes]).to have_key(:name)
    expect(item_merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'sends error code if item does not exist' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)

    get "/api/v1/items/10/merchant"

    expect(response.status).to eq(404)
  end
end