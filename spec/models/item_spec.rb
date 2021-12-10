require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'class methods' do
    it 'finds all items by search criteria' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, name: "Party Hat")
      item_2 = create(:item, name: "Part of a Donut")
      item_3 = create(:item, name: "Partner Boots")
      item_4 = create(:item, name: "Particularly Perfect Pants")

      expect(Item.find_all_items("part")).to eq([item_2, item_4, item_3, item_1])
    end

    it 'finds one item by search criteria' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, name: "Party Hat")
      item_2 = create(:item, name: "Part of a Donut")
      item_3 = create(:item, name: "Partner Boots")
      item_4 = create(:item, name: "Particularly Perfect Pants")

      expect(Item.find_one_item("part")).to eq(item_2)
    end

    it 'finds items by price range' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

      expect(Item.find_by_price_range(1.00, 20.00)).to eq(item_1)
    end

    it 'finds items above min price' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

      expect(Item.find_above(20.00)).to eq(item_2)
    end

    it 'finds items below max_price' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Potato Peeler", description: "It peels your potatoes", unit_price: 10.50, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Pot Belly Pig", description: "It's a pig'", unit_price: 100.00, merchant_id: merchant_1.id)

      expect(Item.find_below(20.00)).to eq(item_1)
    end
  end
end