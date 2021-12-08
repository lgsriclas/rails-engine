class MerchantSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  has_many :items

  def self.merchant_not_found
    {errors:
        {details: 'A merchant with this id does not exist'}
    }
  end 

  attribute :active do
   true
  end
end
