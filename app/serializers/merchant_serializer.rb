class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

  def self.merchant_not_found
    {errors:
        {details: 'A merchant with this id does not exist'}
    }
  end
end
