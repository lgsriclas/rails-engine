class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :merchant_id, presence: true

  def self.find_all_items(name)
    where("name iLIKE :search", search: "%#{name}%").order(:name)
    # Item.all.where("name iLIKE ?", "%#{name}%").order(:name)
    # where("name iLIKE :search", search: "%#{name.downcase}%").order(:name)
  end

  def self.find_one_item(name)
    where("name iLIKE :search", search: "%#{name}%").order(:name).first
  end

  def self.find_by_price_range(min, max)
    where("unit_price >= #{min} AND unit_price <= #{max}").order(:name).first
  end

  def self.find_above(min_price)
    where("unit_price > ?", min_price).order(:name).first
  end

  def self.find_below(max_price)
    where("unit_price < ?", max_price).order(:name).first
  end
end