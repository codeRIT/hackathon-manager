function setupCodeMirror() {
  $('[data-code-mirror-textarea]').each(function(i, element) {
    var myCodeMirror = CodeMirror.fromTextArea(element, {
      lineNumbers: true,
      mode: 'htmlmixed',
    });
    myCodeMirror.setSize(null, window.innerHeight - 200);
  });
}
