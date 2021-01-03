class ArrayInput < SimpleForm::Inputs::StringInput
  def input(_wrapper_options = nil)
    input_html_options[:type] ||= input_type
    existing_values = object.public_send(attribute_name)
    existing_values.push(nil) if existing_values.blank?

    template.content_tag(:div, class: 'text-array', id: "#{object_name}_#{attribute_name}") do
      Array(existing_values).map do |array_el|
        template.concat build_row(array_el)
      end

      template.concat add_button
    end
  end

  def input_type
    :text
  end

  private

  def build_row(val)
    template.content_tag(:div, class: 'text-array__row') do
      template.concat @builder.text_field(nil,
                                          input_html_options.merge(value: val, name: "#{object_name}[#{attribute_name}][]"))
      template.concat remove_button
    end
  end

  def add_button
    '<button class="btn btn-success btn-sm text-array__add" href="#">Add</button>'.html_safe
  end

  def remove_button
    '<button class="btn btn-light btn-sm text-array__remove" href="#">Remove</button>'.html_safe
  end
end
