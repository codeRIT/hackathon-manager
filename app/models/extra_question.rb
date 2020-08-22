class ExtraQuestion < ApplicationRecord
  validates_presence_of :question, :data_type

  POSSIBLE_TYPES = {
    "string" => "string (less than 256 characters)",
    "text" => "string (greater than 255 characters)",
    "datetime" => "date and time",
    "date" => "date",
    "time" => "time",
    "boolean" => "checkbox",
    "integer" => "whole number",
    "float" => "number with decimal"
  }.freeze
end
