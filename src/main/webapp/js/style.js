// Create /WebContent/js/script.js

// Countdown Timer
function updateCountdown() {
    // Set countdown to 3 days from now
    const countDownDate = new Date().getTime() + (3 * 24 * 60 * 60 * 1000);
    
    const countdownElement = document.getElementById('countdown');
    if (!countdownElement) return;
    
    const x = setInterval(function() {
        const now = new Date().getTime();
        const distance = countDownDate - now;
        
        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((distance % (1000 * 60)) / 1000);
        
        countdownElement.innerHTML = `${days}:${hours}:${minutes}:${seconds}`;
        
        if (distance < 0) {
            clearInterval(x);
            countdownElement.innerHTML = "SALE ENDED";
        }
    }, 1000);
}

// Add to Cart Functionality
document.addEventListener('DOMContentLoaded', function() {
    // Initialize countdown
    updateCountdown();
    
    // Add to cart buttons
    const addToCartButtons = document.querySelectorAll('.add-to-cart-btn');
    addToCartButtons.forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-id');
            addToCart(productId);
        });
    });
    
    // Search form submission
    const searchForm = document.querySelector('form[action*="search"]');
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            const searchInput = this.querySelector('input[name="query"]');
            if (!searchInput.value.trim()) {
                e.preventDefault();
                alert('Please enter search keywords');
            }
        });
    }
});

function addToCart(productId) {
    // AJAX request to add to cart
    fetch('${pageContext.request.contextPath}/addToCart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `productId=${productId}&quantity=1`
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Update cart count
            const cartCount = document.querySelector('.cart-count');
            if (cartCount) {
                const currentCount = parseInt(cartCount.textContent) || 0;
                cartCount.textContent = currentCount + 1;
            }
            
            // Show success message
            alert('Product added to cart successfully!');
        } else {
            alert('Error adding product to cart: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Network error. Please try again.');
    });
}