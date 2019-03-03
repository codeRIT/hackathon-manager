require "hackathon_manager/engine"

module HackathonManager
  def self.field_enabled?(field)
    disabled_fields = HackathonConfig.disabled_fields || ''
    !disabled_fields.include?(field.to_s)
  end
end
