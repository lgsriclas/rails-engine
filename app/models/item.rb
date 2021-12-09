class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :merchant_id, presence: true

  def self.find_all_items(name)
    Item.all.where("name ILIKE ?", "%#{name}%").order(:name)
    # where("name iLIKE :search", search: "%#{name.downcase}%").order(:name)
  end

  def self.find_one_item(name)
    # Item.all.where("name ILIKE ?", "%#{name}").order(:name).limit(1)
    Item.all.where("name iLIKE :search", search: "%#{name}%").order(:name).limit(1)
  end
end