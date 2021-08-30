class ErrorResponse
  attr_accessor :error_identifier, :default_message

  ERRORS = [:schools_merge_newSchoolNameMissing,
            :messages_deliever_cannotDeliverAutomated,
            :messages_deliever_cannotDeliverNonDrafted].freeze

  def initialize(error_identifier, default_message = nil)
    @error_identifier = error_identifier
    @default_message  = default_message
  end
end
