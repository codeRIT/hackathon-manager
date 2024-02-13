class Manage::ConfigsController < Manage::ApplicationController
  before_action :limit_write_access_to_directors, only: ["edit", "update"]
  before_action :require_director
  before_action :get_config, only: [:edit, :update, :update_only_css_variables]

  respond_to :html, :json

  def index
    @settings = HackathonConfig
    @basics = HackathonConfig.defined_fields.select { |field| field[:scope] == :basics }
    @questionnaire_settings = HackathonConfig.defined_fields.select { |field| field[:scope] == :applying }
    @styling = HackathonConfig.defined_fields.select { |field| field[:scope] == :styling }
    @communications = HackathonConfig.defined_fields.select { |field| field[:scope] == :communications }
  end

  def edit
  end

  def update
    key = @config[:key]
    value = params[:hackathon_config][key].strip
    value = true if value == "true"
    value = false if value == "false"
    if HackathonConfig.send(key) != value
      HackathonConfig.send("#{key}=", value)
      redirect_to manage_configs_path, notice: "Config \"#{key}\" has been updated."
    else
      redirect_to manage_configs_path, notice: "Config \"#{key}\" was not changed"
    end
  end

  def update_only_css_variables
    key = @config[:key]
    old_value = HackathonConfig.send(key)
    posted_value = params[:hackathon_config][key].strip
    if old_value.include? ':root {'
      # Replace the old CSS variables and keep the extra css
      start_index = old_value.index(':root {')
      end_index = old_value.index('}', start_index) + 1
      pre_value = old_value[0...start_index].rstrip
      post_value = old_value[end_index..-1].lstrip
      new_value = "#{pre_value}\n\n#{posted_value}\n\n#{post_value}".strip
    else
      # Prepend the variable definitions to the existing value
      new_value = "#{posted_value}\n\n#{old_value}"
    end
    params[:hackathon_config][key] = new_value
    update
  end

  def enter_theming_editor
    cookies[:theming_editor] = true
    redirect_to root_path
  end

  def exit_theming_editor
    cookies.delete :theming_editor
    redirect_to manage_configs_path
  end

  private

  def get_config
    key = params[:id]
    @config = HackathonConfig.get_field(key)
  end
end
