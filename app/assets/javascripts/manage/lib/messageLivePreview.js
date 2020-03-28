$.fn.messageLivePreview = function() {
  var updateLivePreview = function() {
    var textarea = $('[data-message-live-preview="textarea"]');
    var iframe = $('[data-message-live-preview="iframe"]');
    var baseSrc = iframe.data('message-live-preview-base-src');
    var newSrc = baseSrc + '?body=' + encodeURIComponent(textarea.val());
    console.log(newSrc);
    iframe.attr('src', newSrc);
  };

  var debouncedUpdateLivePreview = debounce(updateLivePreview, 1000);

  $('[data-message-live-preview="textarea"]').on('change', debouncedUpdateLivePreview);
  $('[data-message-live-preview="textarea"]').on('input', debouncedUpdateLivePreview);
};
