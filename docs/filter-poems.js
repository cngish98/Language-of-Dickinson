/*
 * Filter poem table by period, recipient, and ellipsis in response
 * to checkbox events
 *
 * http://dickinson.obdurodon.org, https://github.com/cngish98/Language-of-Dickinson
 * djb, last modified 2021-04-23
 *
 */
"use strict";
window.addEventListener('DOMContentLoaded', function () {
    /* Attached event listeners to checkboxes */
    const checkboxes = document.querySelectorAll('.poems-filtering-container > input');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener('change', filter_poems, false)
    }
},
false);
function filter_poems() {
    /*
     * Find all table rows
     * Find all checkboxes
     * Get the @id values of the ones that are unchecked
     * Show each table row (momentarily)
     * Hide each table row that contains an unchecked @id value
     */
    const poems = document.querySelectorAll('#dropdownTable > tr');
    const checkboxes = document.querySelectorAll('.poems-filtering-container > input');
    var unchecked_boxes_array = Array. from (checkboxes).filter(item => ! item.checked).map(item => item.id);
    console.log(unchecked_boxes_array);
    for (var i = 0; i < poems.length; i++) {
        poems[i].style.display = 'table-row';
        if (Array. from (poems[i].classList).some(item => unchecked_boxes_array.includes(item))) {
            poems[i].style.display = 'none';
        }
    }
}