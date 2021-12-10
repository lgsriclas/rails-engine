class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  # def self.find_one_merchant(name)
  #   # Item.all.where("name ILIKE ?", "%#{name}").order(:name).limit(1)
  #   where("name iLIKE :search", search: "%#{name}%").order(:name).limit(1)
  # end

  def self.find_one_merchant(name)
    # where('name ILIKE ?', "%#{name}%").order(:name).first
    where("name iLIKE :search", search: "%#{name}%").order(:name).first
  end

  def self.find_all_merchants(name)
    # where("name ILIKE ?", "%#{name}%").order(:name)
    where("name iLIKE :search", search: "%#{name}%").order(:name)
  end
end
