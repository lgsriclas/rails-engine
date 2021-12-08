require 'rails_helper'

describe "Merchant Items API endpoints" do
  it "sends a list of a merchant's items" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(10)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end