/* Hides the methods explanation */
function hideDropdown() {
  var x = document.getElementById("methods-text"); /* Finds the methods explanations */
  if (x.style.display === "none") {
    x.style.display = "block"; /* Shows by default */
  } else {
    x.style.display = "none"; /* Hides when clicked */
  }
}
