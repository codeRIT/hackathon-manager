class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable
  attr_reader :view

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def yes_no_display(value)
    value ? '<span class="badge badge-success">Yes</span>'.html_safe : '<span class="badge badge-secondary">No</span>'.html_safe
  end
end
