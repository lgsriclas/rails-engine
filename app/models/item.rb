class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :merchant_id, presence: true

  def self.top_items_by_revenue(number)
    Item
      .joins(invoices: :transactions)
      .where(invoices: {status: 'shipped'}, transactions: {result: 'success' })
      .group(:id)
      .select("SUM(invoice_items.unit_price * invoice_items.quantity) as total_revenue, items.*")
      .order("total_revenue DESC")
      .limit(number)
  end

  def self.find_all_items(name)
    where("name iLIKE :search", search: "%#{name}%")
    .order(:name)
  end

  def self.find_one_item(name)
    where("name iLIKE :search", search: "%#{name}%")
    .order(:name).first
  end

  def self.find_by_price_range(min, max)
    where("unit_price >= #{min} AND unit_price <= #{max}")
    .order(:name)
    .first
  end

  def self.find_above(min_price)
    where("unit_price > ?", min_price)
    .order(:name)
    .first
  end

  def self.find_below(max_price)
    where("unit_price < ?", max_price)
    .order(:name)
    .first
  end
end