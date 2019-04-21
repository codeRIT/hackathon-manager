class MessageTemplate < Mustache
  def initialize(context, use_examples = false)
    @var_context = context
    @use_examples = use_examples
  end

  def method_missing(method_name, *arguments, &block)
    variable = MessageTemplate.variables[method_name.to_s]
    return evaluate(variable) if variable

    super
  end

  def respond_to_missing?(method_name, include_private = false)
    MessageTemplate.variables.key?(method_name.to_s) || super
  end

  class << self
    def variables
      config["variables"]
    end

    def config
      @config ||= reload_config
    end

    def reload_config
      @config = YAML.load_file('config/template_variables.yml')
    end
  end

  private

  def evaluate(variable)
    return variable["example"] if @use_examples && !variable["use_value_as_example"]

    value = variable["value"]
    instance_eval(value)
  end

  def user
    @user ||= begin
      user_id = @var_context[:user_id]
      return nil if user_id.blank?

      User.find_by_id(user_id)
    end
  end

  def bus_list
    @bus_list ||= begin
      bus_list_id = @var_context[:bus_list_id] || user&.questionnaire&.bus_list_id
      return nil if bus_list_id.blank?

      BusList.find_by_id(bus_list_id)
    end
  end
end
