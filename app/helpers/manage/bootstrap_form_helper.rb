module Manage
  module BootstrapFormHelper
    def bs_vertical_simple_form(path, options, &block)
      bootstrap_options = {
        wrapper: :bootstrap_vertical_form,
        wrapper_mappings: {
          boolean:       :bootstrap_vertical_boolean,
          check_boxes:   :bootstrap_vertical_collection,
          date:          :bootstrap_vertical_multi_select,
          datetime:      :bootstrap_vertical_multi_select,
          file:          :bootstrap_vertical_file,
          radio_buttons: :bootstrap_vertical_collection,
          range:         :bootstrap_vertical_range,
          time:          :bootstrap_vertical_multi_select
        }
      }
      options = options.deep_merge(bootstrap_options)
      patch_simple_form_config do
        simple_form_for(path, options, &block)
      end
    end

    def bs_horizontal_simple_form_for(path, options, &block)
      bootstrap_options = {
        wrapper: :bootstrap_horizontal_form,
        wrapper_mappings: {
          boolean:       :bootstrap_horizontal_boolean,
          check_boxes:   :bootstrap_horizontal_collection,
          date:          :bootstrap_horizontal_multi_select,
          datetime:      :bootstrap_horizontal_multi_select,
          file:          :bootstrap_horizontal_file,
          radio_buttons: :bootstrap_horizontal_collection,
          range:         :bootstrap_horizontal_range,
          time:          :bootstrap_horizontal_multi_select
        }
      }
      options = options.deep_merge(bootstrap_options)
      patch_simple_form_config do
        simple_form_for(path, options, &block)
      end
    end

    private

    def set_config(key, value)
      @saved_values ||= {}
      @saved_values[key] = SimpleForm.send(key)
      SimpleForm.send("#{key}=", value)
    end

    def restore_config
      @saved_values.keys.each do |key|
        value = @saved_values.delete(key)
        SimpleForm.send("#{key}=", value)
      end
    end

    def patch_simple_form_config
      # Values copied from the top of
      # https://github.com/rafaelfranca/simple_form-bootstrap/blob/master/config/initializers/simple_form_bootstrap.rb

      # Default class for buttons
      set_config(:button_class, 'btn')

      # Define the default class of the input wrapper of the boolean input.
      set_config(:boolean_label_class, 'form-check-label')

      # How the label text should be generated altogether with the required text.
      set_config(:label_text, ->(label, required, _explicit_label) { "#{label} #{required}" })

      # Define the way to render check boxes / radio buttons with labels.
      set_config(:boolean_style, :inline)

      # You can wrap each item in a collection of radio/check boxes with a tag
      set_config(:item_wrapper_tag, :div)

      # Defines if the default input wrapper class should be included in radio
      # collection wrappers.
      set_config(:include_default_input_wrapper_class, false)

      # CSS class to add for error notification helper.
      set_config(:error_notification_class, 'alert alert-danger')

      # Method used to tidy up errors. Specify any Rails Array method.
      # :first lists the first message for each field.
      # :to_sentence to list all errors for each field.
      set_config(:error_method, :to_sentence)

      # add validation classes to `input_field`
      set_config(:input_field_error_class, 'is-invalid')
      # set_config(:input_field_valid_class, 'is-valid')

      yield
    ensure
      restore_config
    end
  end
end
