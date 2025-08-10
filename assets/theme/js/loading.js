// Loading Animation
document.addEventListener('DOMContentLoaded', function() {
    // Add loading class to elements
    const elements = document.querySelectorAll('.card, .item-wrapper, .mbr-section-title, .mbr-text');
    elements.forEach(el => {
        el.classList.add('loading');
    });
    
    // Trigger loading animation
    setTimeout(() => {
        elements.forEach((el, index) => {
            setTimeout(() => {
                el.classList.add('loaded');
            }, index * 100);
        });
    }, 300);
    
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Add scroll-triggered animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('loaded');
            }
        });
    }, observerOptions);
    
    // Observe all loading elements
    elements.forEach(el => {
        observer.observe(el);
    });
});
