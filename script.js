// Handle Get Started button click
function handleClick() {
    console.log('Get Started button clicked');
    const contactSection = document.getElementById('contact');
    contactSection.scrollIntoView({ behavior: 'smooth' });
}

// Handle form submission
function handleSubmit(event) {
    event.preventDefault();
    
    const form = event.target;
    const messageDiv = document.getElementById('message');
    
    // Get form values
    const name = form.querySelector('input[type="text"]').value;
    const email = form.querySelector('input[type="email"]').value;
    const message = form.querySelector('textarea').value;
    
    // Validate form
    if (name.trim() === '' || email.trim() === '' || message.trim() === '') {
        showMessage('Please fill in all fields', 'error');
        return;
    }
    
    // Validate email format
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        showMessage('Please enter a valid email address', 'error');
        return;
    }
    
    // Log form data (in real scenario, you'd send this to a server)
    console.log('Form Data:', {
        name: name,
        email: email,
        message: message
    });
    
    // Show success message
    showMessage('Message sent successfully! Thank you for contacting us.', 'success');
    
    // Reset form
    form.reset();
    
    // Hide message after 5 seconds
    setTimeout(() => {
        messageDiv.classList.remove('success', 'error');
        messageDiv.textContent = '';
    }, 5000);
}

// Show message function
function showMessage(text, type) {
    const messageDiv = document.getElementById('message');
    messageDiv.textContent = text;
    messageDiv.classList.add(type);
}

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({ behavior: 'smooth' });
        }
    });
});

// Add scroll animation for elements
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe feature cards
document.querySelectorAll('.feature-card').forEach(card => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(20px)';
    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(card);
});

// Log page load
console.log('Website loaded successfully!');
