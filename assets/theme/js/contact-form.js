// Contact Form Handler - Optimized
document.addEventListener('DOMContentLoaded', function() {
    const forms = document.querySelectorAll('.contact-form');
    
    // Email validation regex - compiled once
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form data efficiently
            const formData = new FormData(form);
            const name = formData.get('name') || '';
            const email = formData.get('email') || '';
            const phone = formData.get('phone') || '';
            const message = formData.get('textarea') || '';
            
            // Validate required fields
            if (!name || !email || !message) {
                showAlert('Please fill in all required fields.', 'danger');
                return;
            }
            
            // Validate email format
            if (!emailRegex.test(email)) {
                showAlert('Please enter a valid email address.', 'danger');
                return;
            }
            
            // Create mailto link
            const mailtoBody = `Name: ${name}\nEmail: ${email}\nPhone: ${phone}\n\nMessage:\n${message}`;
            const mailtoLink = `mailto:info@westmarktalentgroup.com?subject=Contact Form Submission&body=${encodeURIComponent(mailtoBody)}`;
            
            // Show success message
            showAlert('Thank you! Your message has been sent. We\'ll be in touch within 24 hours.', 'success');
            
            // Open email client
            window.open(mailtoLink, '_blank');
            
            // Reset form
            form.reset();
        });
    });
    
    function showAlert(message, type) {
        // Remove existing alerts
        const existingAlerts = document.querySelectorAll('.alert');
        existingAlerts.forEach(alert => alert.remove());
        
        // Create new alert
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} col-12`;
        alertDiv.style.cssText = 'background-color: #f8f9fa; border: 1px solid #dee2e6; color: #495057; border-radius: 4px; padding: 12px 16px; margin-bottom: 1rem;';
        alertDiv.textContent = message;
        
        // Insert alert at the top of the form
        const form = document.querySelector('.contact-form');
        if (form) {
            form.insertBefore(alertDiv, form.firstChild);
            
            // Auto-remove alert after 5 seconds
            setTimeout(() => {
                alertDiv.remove();
            }, 5000);
        }
    }
});
