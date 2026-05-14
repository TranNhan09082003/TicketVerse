/* =============================================
   TICKETVERSE — JavaScript
   Countdown, Animations, Cart, Interactions
   ============================================= */

// === NAVBAR SCROLL EFFECT ===
window.addEventListener('scroll', function () {
    const navbar = document.querySelector('.tv-navbar');
    if (navbar) {
        navbar.classList.toggle('scrolled', window.scrollY > 50);
    }
});

// === COUNTDOWN TIMER ===
function initCountdowns() {
    document.querySelectorAll('[data-countdown]').forEach(function (el) {
        var target = new Date(el.getAttribute('data-countdown')).getTime();
        var timer = setInterval(function () {
            var now = new Date().getTime();
            var diff = target - now;
            if (diff < 0) {
                clearInterval(timer);
                el.innerHTML = '<span class="tv-countdown-ended">Đã diễn ra!</span>';
                return;
            }
            var d = Math.floor(diff / (1000 * 60 * 60 * 24));
            var h = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var m = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            var s = Math.floor((diff % (1000 * 60)) / 1000);

            var boxes = el.querySelectorAll('.tv-countdown-box .num');
            if (boxes.length >= 4) {
                boxes[0].textContent = d.toString().padStart(2, '0');
                boxes[1].textContent = h.toString().padStart(2, '0');
                boxes[2].textContent = m.toString().padStart(2, '0');
                boxes[3].textContent = s.toString().padStart(2, '0');
            }
        }, 1000);
    });
}

// === ANIMATED COUNTERS ===
function animateCounters() {
    document.querySelectorAll('[data-count]').forEach(function (el) {
        var target = parseInt(el.getAttribute('data-count'));
        var duration = 2000;
        var start = 0;
        var startTime = null;

        function step(timestamp) {
            if (!startTime) startTime = timestamp;
            var progress = Math.min((timestamp - startTime) / duration, 1);
            var eased = 1 - Math.pow(1 - progress, 3); // easeOutCubic
            el.textContent = Math.floor(eased * target).toLocaleString('vi-VN') + (el.getAttribute('data-suffix') || '');
            if (progress < 1) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    });
}

// === SCROLL REVEAL ANIMATION ===
function initScrollReveal() {
    var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                entry.target.classList.add('tv-animate');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });

    document.querySelectorAll('.tv-reveal').forEach(function (el) {
        observer.observe(el);
    });
}

// === COUNTER REVEAL ON SCROLL ===
function initCounterReveal() {
    var countersRevealed = false;
    var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting && !countersRevealed) {
                countersRevealed = true;
                animateCounters();
            }
        });
    }, { threshold: 0.3 });

    var statsSection = document.querySelector('.tv-stats');
    if (statsSection) observer.observe(statsSection);
}

// === CART FUNCTIONS ===
var TicketCart = {
    getCount: function () {
        var count = sessionStorage.getItem('tv_cart_count');
        return count ? parseInt(count) : 0;
    },
    updateBadge: function () {
        var badge = document.querySelector('.tv-cart-badge');
        var count = this.getCount();
        if (badge) {
            badge.textContent = count;
            badge.style.display = count > 0 ? 'flex' : 'none';
        }
    },
    addItem: function (ticketId, qty) {
        var count = this.getCount() + (qty || 1);
        sessionStorage.setItem('tv_cart_count', count);
        this.updateBadge();
        this.showToast('Đã thêm vào giỏ hàng! 🎉');
    },
    showToast: function (msg) {
        var toast = document.createElement('div');
        toast.className = 'tv-toast';
        toast.innerHTML = msg;
        toast.style.cssText = 'position:fixed;bottom:30px;right:30px;background:linear-gradient(135deg,#667EEA,#764BA2);color:white;padding:16px 28px;border-radius:16px;font-weight:600;font-size:15px;z-index:9999;animation:fadeInUp 0.4s ease;box-shadow:0 10px 40px rgba(102,126,234,0.3);';
        document.body.appendChild(toast);
        setTimeout(function () {
            toast.style.animation = 'fadeIn 0.3s ease reverse';
            setTimeout(function () { toast.remove(); }, 300);
        }, 2500);
    }
};

// === CATEGORY PILL CLICK ===
function initCategoryPills() {
    document.querySelectorAll('.tv-cat-pill').forEach(function (pill) {
        pill.addEventListener('click', function () {
            document.querySelectorAll('.tv-cat-pill').forEach(function (p) { p.classList.remove('active'); });
            this.classList.add('active');
        });
    });
}

// === RATING STARS ===
function initRatingStars() {
    document.querySelectorAll('.tv-star-rating').forEach(function (container) {
        var stars = container.querySelectorAll('.tv-star');
        var input = container.querySelector('input[type="hidden"]');
        stars.forEach(function (star, index) {
            star.addEventListener('click', function () {
                var value = index + 1;
                if (input) input.value = value;
                stars.forEach(function (s, i) {
                    s.classList.toggle('active', i < value);
                    s.style.color = i < value ? '#FEE140' : '#ddd';
                });
            });
            star.addEventListener('mouseenter', function () {
                stars.forEach(function (s, i) {
                    s.style.color = i <= index ? '#FEE140' : '#ddd';
                });
            });
        });
        container.addEventListener('mouseleave', function () {
            var val = input ? parseInt(input.value) || 0 : 0;
            stars.forEach(function (s, i) {
                s.style.color = i < val ? '#FEE140' : '#ddd';
            });
        });
    });
}

// === FORMAT CURRENCY ===
function formatVND(amount) {
    return new Intl.NumberFormat('vi-VN').format(amount) + ' đ';
}

// === INIT ALL ===
document.addEventListener('DOMContentLoaded', function () {
    initCountdowns();
    initScrollReveal();
    initCounterReveal();
    initCategoryPills();
    initRatingStars();
    TicketCart.updateBadge();
});
