function checkReset() {
  var resetText = "Reset Hackathon";
  var inputText = $("#resetText");
  inputText.keyup(function (){
    document.getElementById("resetButton").disabled = (inputText.val() !== resetText);
  });

}

document.addEventListener('turbolinks:load', function () {
  checkReset();
});
