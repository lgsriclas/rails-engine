require 'rails_helper'

describe "Find Merchants" do
  describe "Find One Merchant" do
    it "can find one merchant when searched for by name" do
      merchant_1 = Merchant.create!(name: "Sally's Silly Sandals")
      merchant_2 = Merchant.create!(name: "Bobbi's Basic Banjos")

      search = "sal"

      get "/api/v1/merchants/find?name=#{search}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a(Hash)
      expect(merchant).to have_key(:data)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it 'returns an empty object if search does not match any merchants' do
      merchant_1 = Merchant.create!(name: "Sally's Silly Sandals")
      merchant_2 = Merchant.create!(name: "Bobbi's Basic Banjos")

      search = "owl"

      get "/api/v1/merchants/find?name=#{search}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to eq({})
    end
  end

  describe "Find All Merchants" do
    it "can find all merchants when searched for by name" do
      merchant_1 = Merchant.create!(name: "Sally's Silly Sandals")
      merchant_2 = Merchant.create!(name: "Bobbi's Basic Banjos")
      merchant_3 = Merchant.create!(name: "Sal's Famous Sicilian Pizza")

      search = "sal"

      get "/api/v1/merchants/find_all?name=#{search}"

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants).to have_key(:data)
      expect(merchants[:data].first).to have_key(:attributes)
      expect(merchants[:data].first[:attributes]).to have_key(:name)
      expect(merchants[:data].first[:attributes][:name]).to be_a(String)
    end
  end
end