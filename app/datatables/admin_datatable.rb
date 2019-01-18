class AdminDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_admin_path, :bold

  def view_columns
    @view_columns ||= {
      id: { source: 'User.id' },
      email: { source: 'User.email' },
      role: { source: 'User.role', searchable: false }
    }
  end

  private

  def data
    records.map do |record|
      {
        id: record.id,
        email: link_to(bold(record.email), manage_admin_path(record)),
        role: record.role.titleize
      }
    end
  end

  # rubocop:disable Naming/AccessorMethodName
  def get_raw_records
    User.where(role: [:admin, :admin_limited_access, :event_tracking])
  end
  # rubocop:enable Naming/AccessorMethodName
end
