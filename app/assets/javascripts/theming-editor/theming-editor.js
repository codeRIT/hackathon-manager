//= require ../vendor/pickr.min.js

(function() {
  function _onTextChange() {
    var $input = $(this);
    var variable = $input.attr('name');
    var value = $input.val();

    document.documentElement.style.setProperty(variable, value);
    window.pickrs[variable].setColor(value, true);
  }

  function _onPickrChange(color, instance) {
    var value = color ? '#' + color.toHEXA().join('') : '';
    var $variable = $(instance.getRoot().root).parents('.theming-editor__variable');
    $input = $variable.find('.theming-editor__input');
    var variable = $input.attr('name');

    // Don't update input if the user is typing in it
    if (!$input.is(':focus')) {
      $input.val(value);
    }
    // Update the picker button color (doesn't by default)
    instance.applyColor(true);
    // Update CSS property
    document.documentElement.style.setProperty(variable, value);
  }

  function onSave() {
    var $editor = $(this).parents('.theming-editor__wrapper');
    var css = ':root {\n';
    $editor.find('.theming-editor__input').each(function() {
      var variable = $(this).attr('name');
      var value = $(this).val();
      css += '  ' + variable + ': ' + value + ';\n';
    });
    css += '}';
    saveConfig(css);
  }

  function saveConfig(css) {
    var data = {
      hackathon_config: {
        custom_css: css,
      },
    };
    fetch('/manage/configs/custom_css', {
      method: 'PATCH',
      redirect: 'manual',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken(),
      },
      body: JSON.stringify(data),
    })
      .then(function(response) {
        if (!response.ok && response.type != 'opaqueredirect') {
          alert('There was an error attempting to save. Please try again or refresh the page.');
          return;
        }
        window.location.replace('/manage/configs/exit_theming_editor');
      })
      .catch(function() {
        alert('There was an error attempting to save. Please try again or refresh the page.');
      });
  }

  var onTextChange = throttle(_onTextChange, 100);
  var onPickrChange = throttle(_onPickrChange, 100);

  function initHtml() {
    var variables = Object.values(getComputedStyle(document.documentElement))
      .filter(function(x) {
        return x.startsWith('--primary');
      })
      .sort();
    var $editor = $('#theming-editor');
    var $variables = $editor.find('.theming-editor__variables');
    var $variable_template = $editor.find('.theming-editor__variable').remove();
    variables.forEach(function(variable) {
      var $new_variable = $variable_template.clone();
      var $code = $new_variable.find('.theming-editor__variable-name-code');
      var $input = $new_variable.find('.theming-editor__input');
      var value = getComputedStyle(document.documentElement)
        .getPropertyValue(variable)
        .trim();

      $code.text(variable);
      $input.val(value);
      $input.attr('name', variable);
      $input.on('input', onTextChange);
      $variables.append($new_variable);
    });
    $editor.find('.theming-editor__button-save').on('click', onSave);
  }

  function initColorPickers() {
    window.pickrs = {};
    $('.theming-editor__color-picker').each(function() {
      var $input = $(this)
        .parents('.theming-editor__variable')
        .find('.theming-editor__input');
      var pickr = Pickr.create({
        el: this,
        default: $input.val(),
        components: {
          opacity: false,
          hue: true,
          interaction: false,
        },
      });
      pickr.on('change', onPickrChange);
      var variable = $input.attr('name');
      window.pickrs[variable] = pickr;
    });
  }

  function init() {
    initHtml();
    initColorPickers();
  }

  document.addEventListener('turbo:load', init);
})();
