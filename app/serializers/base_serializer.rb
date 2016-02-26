class BaseSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  embed :ids
end
