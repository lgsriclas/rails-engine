class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

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
