json.array! @agreements do |agreement|
  json.name       agreement.name
  json.agreement  agreement.agreement
  json.created_at agreement.created_at
  json.updated_at agreement.updated_at
end
