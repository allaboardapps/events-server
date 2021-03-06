class LocationSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :region_id,
    :name,
    :abbreviation,
    :time_zone,
    :archived,
    :test,
    :created_at,
    :updated_at
  )
end
