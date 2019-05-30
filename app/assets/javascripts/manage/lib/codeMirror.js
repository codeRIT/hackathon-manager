function setupCodeMirror() {
  $('[data-code-mirror-textarea]').each(function(i, element) {
    var mode = $(this).data('code-mirror-mode') || 'htmlmixed';
    var myCodeMirror = CodeMirror.fromTextArea(element, {
      lineNumbers: true,
      mode: mode,
    });
    myCodeMirror.setSize(null, window.innerHeight - 250);
  });
}
