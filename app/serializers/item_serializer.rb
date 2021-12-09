class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  # def self.item_not_found
  #   {errors:
  #       {details: 'An item with this id does not exist'}
  #   }
  # end

  # def self.item_not_created
  #   {errors:
  #       {details: 'Item not created'}
  #   }
  # end

  # def self.item_not_updated
  #   {errors:
  #       {details: 'Item not updated'}
  #   }
  # end

  # def self.item_not_destroyed
  #   {errors:
  #       {details: 'Item not deleted'}
  #   }
  # end
end
