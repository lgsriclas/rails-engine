class ItemNameRevenueSerializer
  include JSONAPI::Serializer

  attributes :name

  attributes :revenue do |object|
    object.revenue
  end
end