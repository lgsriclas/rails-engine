class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  validates :name, presence: true

  def self.top_merchants_by_revenue(number)
    Merchant
      .joins(invoices: [:transactions, :invoice_items])
      .where(invoices: {status: 'shipped'}, transactions: {result: 'success' })
      .group(:id)
      .select("SUM(invoice_items.unit_price * invoice_items.quantity) as total_revenue, merchants.*")
      .order("total_revenue DESC")
      .limit(number)
  end

  def self.most_items_sold(number)
    Merchant
      .joins(invoices: [:transactions, :invoice_items])
      .where(invoices: {status: 'shipped'}, transactions: {result: 'success'})
      .select("SUM(invoices_items.quantity) as item_count, merchants.*")
      .group(:id)
      .order("item_count DESC")
      .limit(number)
  end

  def self.total_revenue(merchant_id)
    Merchant
    .joins(invoices: [:transactions, :invoice_items])
    .where(id: id)
    .select("SUM(invoice_items.unit_price * invoice_items.quantity), as revenue, merchants.*")
    .group(:id)
    .first
  end

  def self.find_one_merchant(name)
    where("name iLIKE :search", search: "%#{name}%")
    .order(:name)
    .first
  end

  def self.find_all_merchants(name)
    where("name iLIKE :search", search: "%#{name}%")
    .order(:name)
  end
end
