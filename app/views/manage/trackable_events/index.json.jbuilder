json.array! @trackable_events do |trackable_event|
  json.id                           trackable_event.id
  json.trackable_tag_id             trackable_event.trackable_tag_id
  json.user_id                      trackable_event.user_id
  json.created_at                   trackable_event.created_at
  json.updated_at                   trackable_event.updated_at
end