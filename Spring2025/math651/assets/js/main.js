// Initialize KaTeX and other components when DOM is ready
document.addEventListener("DOMContentLoaded", function() {
    // Initialize KaTeX rendering
    renderMathInElement(document.body, {
        delimiters: [
            {left: '$$', right: '$$', display: true},
            {left: '$', right: '$', display: false},
            {left: '$.', right: '.$', display: false},
            {left: '\\(', right: '\\)', display: false},
            {left: '\\[', right: '\\]', display: true}
        ],
        throwOnError: false
    });

    // Initialize syntax highlighting
    hljs.highlightAll();

    // Setup accordion functionality
    const accordions = document.getElementsByClassName("accordion");
    Array.from(accordions).forEach(accordion => {
        accordion.addEventListener("click", function() {
            this.classList.toggle("active");
            const panel = this.nextElementSibling;
            panel.style.display = panel.style.display === "block" ? "none" : "block";
        });
    });
});

// Navigation toggle functions
function toggleNav() {
    const nav = document.getElementById("nav");
    nav.classList.toggle("showing");
}

function closeNav() {
    document.getElementById("nav").classList.remove("showing");
}

// Prevent transitions when navigating away from the page.
document.addEventListener('click', (e) => {
    if (e.target.tagName === 'A' && e.target.href) {
        document.body.classList.add('navigating');
    }
});