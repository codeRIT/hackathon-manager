module QuestionnaireHelper
  def format_age(age)
    parts = ActiveSupport::Duration.build(age).parts

    "#{pluralize(parts[:years], 'year')}, #{pluralize(parts[:months], 'month')}, and #{pluralize(parts[:days], 'day')}"
  end
end
