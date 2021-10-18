class ErrorResponse
  attr_accessor :error_identifier, :default_message

  ERRORS = [:busLists_sendUpdateEmail_NotesEmpty,
            :login_merge_newSchoolNameMissing,
            :messages_deliever_cannotDeliverAutomated,
            :messages_deliever_cannotDeliverNonDrafted,
            :questionnaire_updateAccStatus_blankStatus,
            :schools_merge_newSchoolNameMissing,
            :config_update_agreementMustStartHTTP].freeze

  def initialize(error_identifier, default_message = nil)
    @error_identifier = error_identifier
    @default_message  = default_message
  end
end
