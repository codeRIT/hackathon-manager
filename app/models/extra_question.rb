class ExtraQuestion < ApplicationRecord
  validates_presence_of :question, :data_type

  before_save :data_type_changed
  before_destroy :remove_from_questionnaire

  serialize :select_collection, Array

  POSSIBLE_TYPES = {
    "string (less than 256 characters)" => "string",
    "string (greater than 255 characters)" => "text",
    # there is a error with storage for these formats
    # "date and time" => "datetime",
    # "date" => "date",
    # "time" => "time",
    "drop down menu" => "select",
    "checkbox" => "boolean",
    "whole number" => "integer",
    "number with decimal" => "float"
  }.freeze

  def data_type_changed
    if data_type_changed?
      Questionnaire.all.each do |questionnaire|
        if questionnaire.extra_question_data.delete(id.to_s)
          questionnaire.save
        end
      end
    end
  end

  def remove_from_questionnaire
    Questionnaire.all.each do |questionnaire|
      if questionnaire.extra_question_data.delete(id.to_s)
        questionnaire.save
      end
    end
  end
end
