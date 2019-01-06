function setupSimpleMde() {
  $("[data-simple-mde]").each(function(i, element) {
    var options = {
      element: element,
      forceSync: true
    };
    if ($(element).data("message-live-preview-base-src")) {
      options["previewRender"] = function(plainText) {
        var iframe = document.createElement("iframe");
        var baseSrc = $(element).data("message-live-preview-base-src");
        var newSrc = baseSrc + "?body=" + encodeURIComponent(plainText);
        iframe.className = "email-preview-in-simplemde";
        iframe.src = newSrc;
        return iframe.outerHTML;
      }.bind(this);
    }
    new SimpleMDE(options);
  });
}
