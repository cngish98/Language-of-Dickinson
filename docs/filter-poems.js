"use strict";
window.addEventListener('DOMContentLoaded', (event) => {
    /* Attach event listeners to checkboxes */
    const checkboxes = document.querySelectorAll('.poems-filtering-container > input');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener('change', filter_poems, false)
    }
    /* Attach event listener to toggle for dropdown table */
    document.getElementById('dropdownButton').addEventListener('click', toggle_table, false);
    /* Attach event listener to toggle theme highlighting */
    const sidebar_checkboxes = document.querySelectorAll('#sidebar-selecting-container > input');
    for (var i = 0; i < sidebar_checkboxes.length; i++) {
        sidebar_checkboxes[i].addEventListener('change', toggle_color, false)
    }
});
function filter_poems() {
    /*
     * Find all checkboxes
     * Get the @id values of the checkboxes that are unchecked
     */
    const checkboxes = document.querySelectorAll('.poems-filtering-container > input');
    var unchecked_boxes_array = Array. from (checkboxes).filter(item => ! item.checked).map(item => item.id);
    /* Find all table rows (toc_poems)
     * Show each table row (momentarily)
     * Hide each table row that contains an unchecked @id value
     */
    const toc_poems = document.querySelectorAll('#dropdownTable > tr');
    for (var i = 0; i < toc_poems.length; i++) {
        toc_poems[i].style.display = 'table-row';
        if (Array. from (toc_poems[i].classList).some(item => unchecked_boxes_array.includes(item))) {
            toc_poems[i].style.display = 'none';
        }
    }
    
    /* Find all poems (poems)
     * Show each poem (momentarily)
     * Hide each poem that contains an unchecked @id  value
     *  */
    const poems = document.getElementsByClassName('poem');
    for (var i = 0; i < poems.length; i++) {
        poems[i].style.display = 'block';
        if (Array. from (poems[i].classList).some(item => unchecked_boxes_array.includes(item))) {
            poems[i].style.display = 'none';
        }
    }
}
function toggle_table() {
    /* Toggle 'hide' @class value for table */
    const toc = document.getElementById('dropdownTable');
    toc.classList.toggle('hide');
}
function toggle_color() {
    /* Toggle color for selected meta-theme */
    const theme_to_toggle = this.id;
    const spans_to_toggle = document.getElementsByClassName(theme_to_toggle);
    // console.log(theme_to_toggle, spans_to_toggle);
    for (var i = 0; i < spans_to_toggle.length; i++) {
        spans_to_toggle[i].classList.toggle('highlight');
    }
}