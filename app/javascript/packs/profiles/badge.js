import Tooltip from "bootstrap/js/dist/tooltip"
(function() {
    window.addEventListener("load", function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new Tooltip(tooltipTriggerEl);
        });
    });
})();