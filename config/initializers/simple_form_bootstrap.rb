# frozen_string_literal: true

# rubocop:disable all

# Please do not make direct changes to this file!
# This generator is maintained by the community around simple_form-bootstrap:
# https://github.com/rafaelfranca/simple_form-bootstrap
# All future development, tests, and organization should happen there.
# Background history: https://github.com/plataformatec/simple_form/issues/1561

# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/plataformatec/simple_form#custom-components
# to know more about custom components.
Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # General config moved to app/helpers/manage/boostrap_form_helper.rb

  # vertical forms
  #
  # vertical default_wrapper
  config.wrappers :bootstrap_vertical_form, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.use :input, class: 'form-control', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical input for boolean
  config.wrappers :bootstrap_vertical_boolean, tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: 'form-check' do |bb|
      bb.use :input, class: 'form-check-input', error_class: 'is-invalid'
      bb.use :label, class: 'form-check-label'
      bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # vertical input for radio buttons and check boxes
  config.wrappers :bootstrap_vertical_collection, item_wrapper_class: 'form-check', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'form-check-input', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical input for inline radio buttons and check boxes
  config.wrappers :bootstrap_vertical_collection_inline, item_wrapper_class: 'form-check form-check-inline', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'form-check-input', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical file input
  config.wrappers :bootstrap_vertical_file, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control-file', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical multi select
  config.wrappers :bootstrap_vertical_multi_select, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |ba|
      ba.use :input, class: 'form-control mx-1', error_class: 'is-invalid'
    end
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical range input
  config.wrappers :bootstrap_vertical_range, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label
    b.use :input, class: 'form-control-range', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # horizontal forms
  #
  # horizontal default_wrapper
  config.wrappers :bootstrap_horizontal_form, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control', error_class: 'is-invalid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal input for boolean
  config.wrappers :bootstrap_horizontal_boolean, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: 'label', class: 'col-sm-3' do |ba|
      ba.use :label_text
    end
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |wr|
      wr.wrapper :form_check_wrapper, tag: 'div', class: 'form-check' do |bb|
        bb.use :input, class: 'form-check-input', error_class: 'is-invalid'
        bb.use :label, class: 'form-check-label'
        bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
        bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
      end
    end
  end

  # horizontal input for radio buttons and check boxes
  config.wrappers :bootstrap_horizontal_collection, item_wrapper_class: 'form-check', tag: 'div', class: 'form-group row', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-check-input', error_class: 'is-invalid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal input for inline radio buttons and check boxes
  config.wrappers :bootstrap_horizontal_collection_inline, item_wrapper_class: 'form-check form-check-inline', tag: 'div', class: 'form-group row', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-check-input', error_class: 'is-invalid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal file input
  config.wrappers :bootstrap_horizontal_file, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, error_class: 'is-invalid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal multi select
  config.wrappers :bootstrap_horizontal_multi_select, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |bb|
        bb.use :input, class: 'form-control mx-1', error_class: 'is-invalid'
      end
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal range input
  config.wrappers :bootstrap_horizontal_range, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control-range', error_class: 'is-invalid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end


  # inline forms
  #
  # inline default_wrapper
  config.wrappers :bootstrap_inline_form, tag: 'span', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: 'form-control', error_class: 'is-invalid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.optional :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # inline input for boolean
  config.wrappers :bootstrap_inline_boolean, tag: 'span', class: 'form-check flex-wrap justify-content-start mr-sm-2', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'form-check-input', error_class: 'is-invalid'
    b.use :label, class: 'form-check-label'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.optional :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # bootstrap custom forms
  #
  # custom input for boolean
  config.wrappers :bootstrap_custom_boolean, tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: 'custom-control custom-checkbox' do |bb|
      bb.use :input, class: 'custom-control-input', error_class: 'is-invalid'
      bb.use :label, class: 'custom-control-label'
      bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :bootstrap_custom_boolean_switch, tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: 'custom-control custom-checkbox-switch' do |bb|
      bb.use :input, class: 'custom-control-input', error_class: 'is-invalid'
      bb.use :label, class: 'custom-control-label'
      bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # custom input for radio buttons and check boxes
  config.wrappers :bootstrap_custom_collection, item_wrapper_class: 'custom-control', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'custom-control-input', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom input for inline radio buttons and check boxes
  config.wrappers :bootstrap_custom_collection_inline, item_wrapper_class: 'custom-control custom-control-inline', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'custom-control-input', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom file input
  config.wrappers :bootstrap_custom_file, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper :custom_file_wrapper, tag: 'div', class: 'custom-file' do |ba|
      ba.use :input, class: 'custom-file-input', error_class: 'is-invalid'
      ba.use :label, class: 'custom-file-label'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    end
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom multi select
  config.wrappers :bootstrap_custom_multi_select, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |ba|
      ba.use :input, class: 'custom-select mx-1', error_class: 'is-invalid'
    end
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom range input
  config.wrappers :bootstrap_custom_range, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label, class: 'form-control-label'
    b.use :input, class: 'custom-range', error_class: 'is-invalid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # Input Group - custom component
  # see example app and config at https://github.com/rafaelfranca/simple_form-bootstrap
  config.wrappers :bootstrap_input_group, tag: 'div', class: 'form-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper :input_group_tag, tag: 'div', class: 'input-group' do |ba|
      ba.optional :prepend
      ba.use :input, class: 'form-control', error_class: 'is-invalid'
      ba.optional :append
    end
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # Floating Labels form
  #
  # floating labels default_wrapper
  config.wrappers :bootstrap_floating_labels_form, tag: 'div', class: 'form-label-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: 'form-control', error_class: 'is-invalid'
    b.use :label, class: 'form-control-label'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom multi select
  config.wrappers :bootstrap_floating_labels_select, tag: 'div', class: 'form-label-group', error_class: 'form-group-invalid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'custom-select custom-select-lg', error_class: 'is-invalid'
    b.use :label, class: 'form-control-label'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # # The default wrapper to be used by the FormBuilder.
  # config.default_wrapper = :vertical_form

  # # Custom wrappers for input types. This should be a hash containing an input
  # # type as key and the wrapper that will be used for all inputs with specified type.
  # config.wrapper_mappings = {
  #   boolean:       :vertical_boolean,
  #   check_boxes:   :vertical_collection,
  #   date:          :vertical_multi_select,
  #   datetime:      :vertical_multi_select,
  #   file:          :vertical_file,
  #   radio_buttons: :vertical_collection,
  #   range:         :vertical_range,
  #   time:          :vertical_multi_select
  # }

  # enable custom form wrappers
  # config.wrapper_mappings = {
  #   boolean:       :custom_boolean,
  #   check_boxes:   :custom_collection,
  #   date:          :custom_multi_select,
  #   datetime:      :custom_multi_select,
  #   file:          :custom_file,
  #   radio_buttons: :custom_collection,
  #   range:         :custom_range,
  #   time:          :custom_multi_select
  # }
end
# rubocop:enable all
