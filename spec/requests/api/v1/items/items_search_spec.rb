require 'rails_helper'

describe "Find Items" do
  describe 'happy path' do
    it "returns all items in alphabetical order when searched for by name" do
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
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)
    end

    it 'can find items when searched for by min_price' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

      get "/api/v1/items/find?min_price=20.00"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data][:attributes][:name]).to eq(item_2.name)
    end

    it 'can find items when searched for by max_price' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

      get "/api/v1/items/find?max_price=20.00"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data][:attributes][:name]).to eq(item_1.name)
    end

    it 'can find items when searched by price range' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)


      get "/api/v1/items/find_all?min_price=5.00&max_price=500.00"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:data)
      expect(items[:data].count).to eq 2
      expect(items[:data].first[:attributes][:name]).to eq(item_2.name)
    end
  end

  describe "sad path" do
    it 'returns nil if search has no matches' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

      search = "owl"

      get "/api/v1/items/find?name=#{search}"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to have_key(:data)
      expect(item[:data]).to eq(nil)
    end

    xit 'sends an error if name and price params are searched' do
      get '/api/v1/items/find_all?name=lesley&min_price=1.00'

      expect(response.status).to eq(400)
    end

    xit 'sends an error if name param is empty' do
      get '/api/v1/items/find_all?name=&min_price=1.00'

      expect(response.status).to eq(400)
    end

    xit 'sends an error if price is less than 0' do
      get '/api/v1/items/find_all?name=lesley&min_price=-1.00'

      expect(response.status).to eq(400)
    end
  end
end