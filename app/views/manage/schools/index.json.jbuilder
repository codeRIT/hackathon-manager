json.array! @schools do |school|
  json.id                   school.id
  json.name                 school.name
  json.address              school.address
  json.city                 school.city
  json.state                school.state
  json.questionnaire_count  school.questionnaire_count
  json.is_home              school.is_home
  json.created_at           school.created_at
  json.updated_at           school.updated_at
end
