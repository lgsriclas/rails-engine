require 'rails_helper'

describe "Item Update API endpoint" do
  it "can update an item" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    name = Item.first.name
    description = Item.first.description
    unit_price = Item.first.unit_price
    merchant_id = Item.first.merchant_id

    item_params = {
                    name: "DIY Sand Castle",
                    description: "Build your own Dune!",
                    unit_price: 50.00,
                    merchant_id: merchant_1.id
                  }

    header = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item_1.id}", headers: header, params: JSON.generate(item_params)

    item = Item.find_by(id: item_1)

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.name).to_not eq(name)
    expect(item.description).to eq(item_params[:description])
    expect(item.description).to_not eq(description)
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.unit_price).to_not eq(unit_price)
    expect(item.merchant_id).to eq(item_params[:merchant_id])
    expect(item.description).to_not eq(merchant_id)
  end

  it 'sends error code if item does not update' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    name = Item.first.name
    description = Item.first.description
    unit_price = Item.first.unit_price
    merchant_id = Item.first.merchant_id

    item_params = {
                    name: "",
                    description: "Build your own Dune!",
                    unit_price: 50.00,
                    merchant_id: merchant_1.id
                  }

    header = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item_1.id}", headers: header, params: JSON.generate(item_params)

    Item.find_by(id: item_1)

    expect(response.status).to eq(404)
  end
end