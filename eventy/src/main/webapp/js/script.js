document.addEventListener("DOMContentLoaded", () => {
    console.log("✅ Eventy frontend loaded successfully");

    // Optional: Simple client-side validation feedback (optional)
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', () => {
            console.log("Form submitted to backend...");
            // No preventDefault() → real form submission to servlet
        });
    });
});