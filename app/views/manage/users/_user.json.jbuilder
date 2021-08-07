json.(user, :id, :first_name, :last_name, :email, :password, :password_confirmation,
  :remember_me, :role, :is_active, :receive_weekly_report)
json.token user.generate_jwt
