require 'rails_helper'

describe "Item Delte API endpoints" do
  it "can delete an item" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)

    expect(Item.count).to eq(2)

    delete "/api/v1/items/#{item_1.id}"

    expect(response).to be_successful
  end
end