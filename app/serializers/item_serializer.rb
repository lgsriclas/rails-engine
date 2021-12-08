class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  def self.item_not_found
    {errors:
        {details: 'An item with this id does not exist'}
    }
  end

  def self.not_created
    {errors:
        {details: 'Item was not created.'}
    }
  end
end
