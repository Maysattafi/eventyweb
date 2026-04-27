/* Eventy — script.js */

/* ── NAVBAR SCROLL EFFECT ── */
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
    if (window.scrollY > 30) {
        navbar.style.background = 'rgba(10, 14, 26, 0.97)';
        navbar.style.borderBottomColor = 'rgba(255,255,255,0.1)';
    } else {
        navbar.style.background = 'rgba(10, 14, 26, 0.85)';
        navbar.style.borderBottomColor = 'rgba(255,255,255,0.07)';
    }
});

/* ── CAROUSEL ── */
function scrollCarousel(direction) {
    const track = document.getElementById('carouselTrack');
    if (!track) return;
    const cardWidth = track.querySelector('.event-card').offsetWidth + 20;
    track.scrollBy({ left: direction * cardWidth, behavior: 'smooth' });
}

/* ── SEARCH TAGS ── */
document.querySelectorAll('.search-tags .tag').forEach(tag => {
    tag.addEventListener('click', () => {
        document.querySelectorAll('.search-tags .tag').forEach(t => t.classList.remove('active'));
        tag.classList.add('active');
    });
});

/* ── CARD BOOKMARK TOGGLE ── */
document.querySelectorAll('.card-bookmark').forEach(btn => {
    btn.addEventListener('click', (e) => {
        e.stopPropagation();
        btn.classList.toggle('bookmarked');
        const svg = btn.querySelector('svg');
        if (btn.classList.contains('bookmarked')) {
            svg.setAttribute('fill', 'currentColor');
            btn.style.color = '#3b82f6';
            btn.style.background = 'rgba(59,130,246,0.15)';
        } else {
            svg.setAttribute('fill', 'none');
            btn.style.color = '';
            btn.style.background = '';
        }
    });
});

/* ── SEARCH INPUT FOCUS ANIMATION ── */
const searchInput = document.querySelector('.search-box input');
if (searchInput) {
    searchInput.addEventListener('focus', () => {
        document.querySelector('.search-box').style.transform = 'scale(1.01)';
    });
    searchInput.addEventListener('blur', () => {
        document.querySelector('.search-box').style.transform = 'scale(1)';
    });
}

/* ── SCROLL REVEAL ── */
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

document.querySelectorAll('.event-card, .list-item').forEach((el, i) => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = `opacity 0.5s ease ${i * 0.08}s, transform 0.5s ease ${i * 0.08}s, box-shadow 0.3s, border-color 0.3s, background 0.3s`;
    observer.observe(el);
});

    function filterByCategory(category) {
    document.getElementById('categoryInput').value = category;

    // Highlight active tag
    document.querySelectorAll('.search-tags .tag').forEach(tag => {
    tag.classList.remove('active');
    if ((category === 'all' && tag.textContent.trim() === 'Tous') ||
    tag.textContent.trim() === category) {
    tag.classList.add('active');
}
});

    document.getElementById('searchForm').submit();
}