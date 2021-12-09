require 'rails_helper'

describe "Find Items" do
  xit "can find all items when searched for by name" do
    merchant_1 = create(:merchant)
    item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

    get '/api/v1/items/find_all_items?name=it'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  end

  xit "can find one item when searched for by name" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)

    get '/api/v1/items/find_all_items?name=si'

    # expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  end
end