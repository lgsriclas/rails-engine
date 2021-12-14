class MerchantItemsSoldSerializer
  include JSONAPI::Serializer

  attributes :name

  attributes :count do |object|
    object.item_count
  end
end