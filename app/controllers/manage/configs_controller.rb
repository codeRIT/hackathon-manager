class Manage::ConfigsController < Manage::ApplicationController
  before_action :limit_access_admin
  before_action :get_config, only: [:edit, :update]

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
    value = true if value == 'true'
    value = false if value == 'false'
    if @config.value != value
      @config.value = value
      @config.save
      redirect_to manage_configs_path, notice: 'Config has updated.'
    else
      redirect_to manage_configs_path
    end
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

  private

  def limit_access_admin
    redirect_to manage_root_path unless current_user.admin?
  end
end
