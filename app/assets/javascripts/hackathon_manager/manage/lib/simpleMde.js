function setupSimpleMde() {
  $("[data-simple-mde]").each((i, element) => {
    const options = {
      element: element,
      forceSync: true
    };
    if ($(element).data("message-live-preview-base-src")) {
      options["previewRender"] = plainText => {
        const iframe = document.createElement("iframe");
        var baseSrc = $(element).data("message-live-preview-base-src");
        var newSrc = baseSrc + "?body=" + encodeURIComponent(plainText);
        iframe.className = "email-preview-in-simplemde";
        iframe.src = newSrc;
        return iframe.outerHTML;
      };
    }
    new SimpleMDE(options);
  });
}
