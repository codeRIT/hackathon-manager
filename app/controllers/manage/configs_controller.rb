class Manage::ConfigsController < Manage::ApplicationController
  before_action :require_director
  before_action :get_config, only: [:edit, :update, :update_only_css_variables]

  respond_to :html, :json

  def index
    @config = HackathonConfig.get_all
    respond_with(HackathonConfig.get_all)
  end

  def edit
  end

  def update
    key = @config.var.to_sym
    value = params[:hackathon_config][key]
    value = true if value == "true"
    value = false if value == "false"
    if @config.var.end_with?("_asset") && !value.start_with?('http://', 'https://')
      flash[:alert] = "Config \"#{key}\" must start with http:// or https://"
      render :edit
    elsif @config.value != value
      @config.value = value
      @config.save
      redirect_to manage_configs_path, notice: "Config \"#{key}\" has been updated."
    else
      redirect_to manage_configs_path, notice: "Config \"#{key}\" was not changed"
    end
  end

  def update_only_css_variables
    key = @config.var.to_sym
    old_value = @config.value.strip
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
    var = params[:id]
    @config = HackathonConfig.find_by(var: var)
    if @config.blank?
      @config = HackathonConfig.new(var: var)
      @config.value = HackathonConfig[var]
    end
  end
end
