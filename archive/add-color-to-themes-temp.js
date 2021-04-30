/* NEW CODE FOR THEME CHECKBOXES
 * 
 * 
 * 
 *  */
/* Add event listeners to theme checkboxes */
window.addSidebarEventListener('DOMContentLoaded', (event) => {
    const sidebar_checkboxes = document.querySelectorAll('.sidebar-box > input');
    for (var i = 0; i < sidebar_checkboxes.length; i++) {
        checkboxes[i].addEventListener('change', add_color, false)
    }
});

/*  */
function add_color() {
    /*
     * Find all checkboxes
     * Get the @id values of the checkboxes that are unchecked
     */
    const sidebar_checkboxes = document.querySelectorAll('.sidebar-box > input');
    var sidebar_unchecked_boxes_array = Array. from 
    (sidebar_checkboxes).filter(item => ! item.checked).map(item => item.id);
    }
    
    /* Find poem text */
    const poem_themes = document.querySelectorAll('.poem > span');
    for (var i = 0; i < poem-themes.length; i++) {
        poem_themes[i].style.color = black; /* should display non-checked elements as black */
        if (Array. from (poem_themes[i].classList).some(item => sidebar_unchecked_boxes_array.includes(item))) {
            poem_themes[i].style.color = red; /* needs changed: should display checked elements with correct colors */
        }
     }

/* END NEW CODE 
 * 
 * 
 *  */