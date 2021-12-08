require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 10)
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

  it "can get one merchant by its id" do
    get "/api/v1/merchants/1"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(Integer)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end
end