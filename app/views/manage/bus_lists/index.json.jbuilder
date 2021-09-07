json.array! @bus_lists do |bus_list|
  json.name               bus_list.name
  json.notes              bus_list.notes
  json.capacity           bus_list.capacity
  json.needs_bus_captain  bus_list.needs_bus_captain
  json.created_at         bus_list.created_at
  json.updated_at         bus_list.updated_at
end
