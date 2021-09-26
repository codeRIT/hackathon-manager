json.array! @users do |user|
    json.id                     user.id
    json.first_name             user.first_name
    json.last_name              user.last_name
    json.email                  user.email
    json.role                   user.role
    json.is_active              user.is_active
    json.receive_weekly_report  user.receive_weekly_report
    json.created_at             user.created_at
    json.updated_at             user.updated_at
end