class Manage::ConfigsController < Manage::ApplicationController
  before_action :require_director
  before_action :get_config, only: [:edit, :update, :update_only_css_variables]

  respond_to :json

  def update
    key = @config.var.to_sym
    value = params[:hackathon_config][key]
    value = true if value == "true"
    value = false if value == "false"
    if @config.value != value
      @config.value = value
      if @config.save
        head :ok
      else
        head :unprocessable_entity
      end
    else
      head :ok
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
