// ===================================
// Configuration
// ===================================

const CONFIG = {
    // Replace with your WhatsApp business number (include country code, no + or spaces)
    // Example: '15551234567' for US number (555) 123-4567
    whatsappNumber: '15551234567',

    // Default WhatsApp message
    whatsappMessage: 'Hi! I\'m interested in booking a Google Ads strategy session for my local business.',

    // Form submission endpoint (replace with your actual endpoint)
    formEndpoint: 'https://formspree.io/f/your-form-id', // or your custom endpoint

    // Email for notifications (if using mailto as fallback)
    email: 'info@localadspro.com'
};

// ===================================
// WhatsApp Integration
// ===================================

function openWhatsApp(customMessage = null) {
    const message = customMessage || CONFIG.whatsappMessage;
    const encodedMessage = encodeURIComponent(message);
    const whatsappURL = `https://wa.me/${CONFIG.whatsappNumber}?text=${encodedMessage}`;

    // Track analytics if you have Google Analytics
    if (typeof gtag !== 'undefined') {
        gtag('event', 'whatsapp_click', {
            'event_category': 'engagement',
            'event_label': 'WhatsApp Button Click'
        });
    }

    // Open WhatsApp in new tab
    window.open(whatsappURL, '_blank');
}

// ===================================
// Modal Functions
// ===================================

function openBookingForm(packageName = '') {
    const modal = document.getElementById('bookingModal');
    const packageInput = document.getElementById('packageInterest');

    if (packageInput && packageName) {
        packageInput.value = packageName + ' Plan';
    }

    modal.style.display = 'block';
    document.body.style.overflow = 'hidden'; // Prevent background scrolling

    // Track analytics
    if (typeof gtag !== 'undefined') {
        gtag('event', 'form_open', {
            'event_category': 'engagement',
            'event_label': 'Booking Form Opened',
            'value': packageName
        });
    }
}

function closeBookingForm() {
    const modal = document.getElementById('bookingModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto'; // Re-enable scrolling

    // Reset form
    const form = document.getElementById('bookingForm');
    const successMessage = document.getElementById('formSuccess');

    if (form) {
        form.style.display = 'block';
        form.reset();
    }

    if (successMessage) {
        successMessage.style.display = 'none';
    }
}

// Close modal when clicking outside
window.onclick = function(event) {
    const modal = document.getElementById('bookingModal');
    if (event.target === modal) {
        closeBookingForm();
    }
};

// Close modal on ESC key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeBookingForm();
    }
});

// ===================================
// Form Handling
// ===================================

function handleFormSubmit(event) {
    event.preventDefault();

    const form = event.target;
    const formData = new FormData(form);

    // Convert form data to object
    const formObject = {};
    formData.forEach((value, key) => {
        formObject[key] = value;
    });

    // Track analytics
    if (typeof gtag !== 'undefined') {
        gtag('event', 'form_submit', {
            'event_category': 'conversion',
            'event_label': 'Booking Form Submitted'
        });
    }

    // Show loading state
    const submitButton = form.querySelector('button[type="submit"]');
    const originalButtonText = submitButton.innerHTML;
    submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
    submitButton.disabled = true;

    // Submit to your endpoint
    fetch(CONFIG.formEndpoint, {
        method: 'POST',
        body: formData,
        headers: {
            'Accept': 'application/json'
        }
    })
    .then(response => {
        if (response.ok) {
            // Show success message
            showSuccessMessage();

            // Send to WhatsApp as backup
            sendToWhatsApp(formObject);
        } else {
            throw new Error('Form submission failed');
        }
    })
    .catch(error => {
        console.error('Error:', error);

        // Fallback: Send directly to WhatsApp
        alert('Taking you to WhatsApp to complete your booking...');
        sendToWhatsApp(formObject);
        closeBookingForm();
    })
    .finally(() => {
        submitButton.innerHTML = originalButtonText;
        submitButton.disabled = false;
    });
}

function showSuccessMessage() {
    const form = document.getElementById('bookingForm');
    const successMessage = document.getElementById('formSuccess');

    form.style.display = 'none';
    successMessage.style.display = 'block';

    // Confetti effect (optional - using simple animation)
    createConfetti();
}

function sendToWhatsApp(formData) {
    const message = `
🎯 New Booking Request!

📝 Name: ${formData.fullName}
🏢 Business: ${formData.businessName}
📧 Email: ${formData.email}
📱 Phone: ${formData.phone}
🏭 Business Type: ${formData.businessType}
📍 Location: ${formData.location}
💰 Budget: ${formData.monthlyBudget}
📦 Package: ${formData.packageInterest || 'Not specified'}

💬 Message:
${formData.message || 'No additional message'}
    `.trim();

    openWhatsApp(message);
}

// ===================================
// Smooth Scroll
// ===================================

function smoothScroll(targetId) {
    const element = document.getElementById(targetId);
    if (element) {
        element.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    }
}

// ===================================
// Animation on Scroll
// ===================================

function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe elements with animation
    const animatedElements = document.querySelectorAll('.pain-card, .service-card, .testimonial-card, .pricing-card, .step, .faq-item');

    animatedElements.forEach((el, index) => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = `all 0.6s ease ${index * 0.1}s`;
        observer.observe(el);
    });
}

// ===================================
// Confetti Effect
// ===================================

function createConfetti() {
    const colors = ['#25D366', '#0066FF', '#10B981', '#F59E0B', '#EF4444'];
    const confettiCount = 50;

    for (let i = 0; i < confettiCount; i++) {
        const confetti = document.createElement('div');
        confetti.style.position = 'fixed';
        confetti.style.width = '10px';
        confetti.style.height = '10px';
        confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
        confetti.style.left = Math.random() * 100 + '%';
        confetti.style.top = '-10px';
        confetti.style.opacity = '1';
        confetti.style.transform = `rotate(${Math.random() * 360}deg)`;
        confetti.style.zIndex = '10000';
        confetti.style.pointerEvents = 'none';
        confetti.style.borderRadius = '50%';

        document.body.appendChild(confetti);

        const duration = Math.random() * 3 + 2;
        const delay = Math.random() * 0.5;

        confetti.animate([
            {
                transform: `translateY(0) rotate(0deg)`,
                opacity: 1
            },
            {
                transform: `translateY(${window.innerHeight + 10}px) rotate(${Math.random() * 720}deg)`,
                opacity: 0
            }
        ], {
            duration: duration * 1000,
            delay: delay * 1000,
            easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
        });

        // Remove confetti after animation
        setTimeout(() => {
            confetti.remove();
        }, (duration + delay) * 1000);
    }
}

// ===================================
// Sticky Header
// ===================================

function initStickyHeader() {
    const header = document.querySelector('.header');
    let lastScroll = 0;

    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;

        if (currentScroll > 100) {
            header.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.1)';
        } else {
            header.style.boxShadow = '0 1px 2px 0 rgba(0, 0, 0, 0.05)';
        }

        lastScroll = currentScroll;
    });
}

// ===================================
// Form Validation
// ===================================

function initFormValidation() {
    const form = document.getElementById('bookingForm');
    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');

    inputs.forEach(input => {
        input.addEventListener('blur', () => {
            validateField(input);
        });

        input.addEventListener('input', () => {
            if (input.classList.contains('error')) {
                validateField(input);
            }
        });
    });
}

function validateField(field) {
    const value = field.value.trim();
    let isValid = true;
    let errorMessage = '';

    if (field.hasAttribute('required') && !value) {
        isValid = false;
        errorMessage = 'This field is required';
    } else if (field.type === 'email' && value) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(value)) {
            isValid = false;
            errorMessage = 'Please enter a valid email address';
        }
    } else if (field.type === 'tel' && value) {
        const phoneRegex = /^[\d\s\-\+\(\)]+$/;
        if (!phoneRegex.test(value) || value.length < 10) {
            isValid = false;
            errorMessage = 'Please enter a valid phone number';
        }
    }

    if (!isValid) {
        field.classList.add('error');
        field.style.borderColor = '#EF4444';
        showFieldError(field, errorMessage);
    } else {
        field.classList.remove('error');
        field.style.borderColor = '#E5E5E5';
        removeFieldError(field);
    }

    return isValid;
}

function showFieldError(field, message) {
    removeFieldError(field); // Remove existing error first

    const errorDiv = document.createElement('div');
    errorDiv.className = 'field-error';
    errorDiv.style.color = '#EF4444';
    errorDiv.style.fontSize = '0.875rem';
    errorDiv.style.marginTop = '0.25rem';
    errorDiv.textContent = message;

    field.parentNode.appendChild(errorDiv);
}

function removeFieldError(field) {
    const existingError = field.parentNode.querySelector('.field-error');
    if (existingError) {
        existingError.remove();
    }
}

// ===================================
// Track Scroll Depth (Analytics)
// ===================================

function initScrollDepthTracking() {
    let milestones = {25: false, 50: false, 75: false, 100: false};

    window.addEventListener('scroll', () => {
        const scrollPercent = (window.scrollY / (document.documentElement.scrollHeight - window.innerHeight)) * 100;

        Object.keys(milestones).forEach(milestone => {
            if (scrollPercent >= milestone && !milestones[milestone]) {
                milestones[milestone] = true;

                if (typeof gtag !== 'undefined') {
                    gtag('event', 'scroll_depth', {
                        'event_category': 'engagement',
                        'event_label': `${milestone}% Scrolled`
                    });
                }
            }
        });
    });
}

// ===================================
// Initialize Everything
// ===================================

document.addEventListener('DOMContentLoaded', function() {
    // WhatsApp Button Handlers
    const whatsappButtons = [
        document.getElementById('headerWhatsAppBtn'),
        document.getElementById('heroWhatsAppBtn'),
        document.getElementById('ctaWhatsAppBtn'),
        document.getElementById('floatingWhatsAppBtn')
    ];

    whatsappButtons.forEach(button => {
        if (button) {
            button.addEventListener('click', () => openWhatsApp());
        }
    });

    // Calendar Button Handlers
    const calendarButtons = [
        document.getElementById('heroCalendarBtn'),
        document.getElementById('ctaCalendarBtn')
    ];

    calendarButtons.forEach(button => {
        if (button) {
            button.addEventListener('click', () => openBookingForm());
        }
    });

    // Form Submit Handler
    const bookingForm = document.getElementById('bookingForm');
    if (bookingForm) {
        bookingForm.addEventListener('submit', handleFormSubmit);
    }

    // Initialize features
    initScrollAnimations();
    initStickyHeader();
    initFormValidation();
    initScrollDepthTracking();

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').slice(1);
            smoothScroll(targetId);
        });
    });

    console.log('✅ LocalAds Pro website loaded successfully!');
    console.log('📱 WhatsApp Number:', CONFIG.whatsappNumber);
    console.log('💡 Remember to update the WhatsApp number and form endpoint in script.js');
});

// ===================================
// Performance Monitoring
// ===================================

// Log page load performance
window.addEventListener('load', () => {
    if (window.performance) {
        const perfData = window.performance.timing;
        const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart;

        console.log(`⚡ Page Load Time: ${pageLoadTime}ms`);

        if (typeof gtag !== 'undefined') {
            gtag('event', 'page_load_time', {
                'event_category': 'performance',
                'value': pageLoadTime
            });
        }
    }
});

// ===================================
// Helper Functions
// ===================================

// Debounce function for performance
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Format phone number
function formatPhoneNumber(phoneNumber) {
    const cleaned = ('' + phoneNumber).replace(/\D/g, '');
    const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
    if (match) {
        return '(' + match[1] + ') ' + match[2] + '-' + match[3];
    }
    return phoneNumber;
}

// Auto-format phone input
const phoneInput = document.getElementById('phone');
if (phoneInput) {
    phoneInput.addEventListener('input', debounce(function(e) {
        const formatted = formatPhoneNumber(e.target.value);
        if (formatted !== e.target.value) {
            e.target.value = formatted;
        }
    }, 300));
}

// ===================================
// Export functions for global access
// ===================================

window.openBookingForm = openBookingForm;
window.closeBookingForm = closeBookingForm;
window.openWhatsApp = openWhatsApp;
