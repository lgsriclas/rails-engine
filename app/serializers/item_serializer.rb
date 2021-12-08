class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  belongs_to :merchant

  def self.item_not_found
    {errors:
        {details: 'An item with this id does not exist'}
    }
  end

  attribute :active do
   true
  end
end
