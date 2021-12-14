require 'rails_helper'

describe "Merchants Revenue API endpoints" do
  it "sends a list of merchants with the highest total revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    item_3 = create(:item, merchant: merchant_1)
    item_4 = create(:item, merchant: merchant_2)
    item_5 = create(:item, merchant: merchant_2)
    item_6 = create(:item, merchant: merchant_3)
    item_7 = create(:item, merchant: merchant_4)
    item_8 = create(:item, merchant: merchant_5)

    get '/api/v1/revenue/merchants?/quantity=3'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a(Hash)
    expect(merchants[:data]).to be_an(Array)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end