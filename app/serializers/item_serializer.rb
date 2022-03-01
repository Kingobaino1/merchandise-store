class ItemSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :price
end
