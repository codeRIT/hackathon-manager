class ErrorResponse
  attr_accessor :error_identifier, :default_message

  ERRORS = [:login_merge_newSchoolNameMissing].freeze

  def initialize(error_identifier, default_message = nil)
    @error_identifier = error_identifier
    @default_message  = default_message
  end
end
