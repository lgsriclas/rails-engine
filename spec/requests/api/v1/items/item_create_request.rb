require 'rails_helper'

describe "Item Create API endpoints" do
  it "can create an item" do
    merchant_1 = create(:merchant)

    item_params = ({
                    name: "Purple Sparkle Leggings",
                    description: "Lounge in style!",
                    unit_price: 20.00,
                    merchant_id: merchant_1.id
                  })

    header = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items/", headers: header, params: JSON.generate(item_params)

    expect(response).to be_successful

    new_item = Item.last

    expect(Item.count).to eq(1)
    expect(new_item.name).to eq("Purple Sparkle Leggings")
    expect(new_item.description).to eq("Lounge in style!")
    expect(new_item.unit_price).to eq(20.00)
  end
end