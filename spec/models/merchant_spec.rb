require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    before :each do
      @merchant = create_list(:merchant, 5)
      @item_1 = create(:item, merchant: merchant[0])
      @item_2 = create(:item, merchant: merchant[0])
      @item_3 = create(:item, merchant: merchant[0])
      @item_4 = create(:item, merchant: merchant[1])
      @item_5 = create(:item, merchant: merchant[1])
      @item_6 = create(:item, merchant: merchant[2])
      @item_7 = create(:item, merchant: merchant[3])
      @item_8 = create(:item, merchant: merchant[4])
    end

    it 'find the top merchants by revenue' do
      expect(Merchant.top_merchants_by_revenue(3)).to eq([merchant_1, merchant_2, merchant_3])
    end
  end
end
