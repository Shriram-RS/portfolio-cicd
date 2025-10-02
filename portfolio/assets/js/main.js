// SWIPER PROJECTS
const projectsSwiper = new Swiper('.projects-swiper', {
  slidesPerView: 1,
  spaceBetween: 20,
  loop: true,
  pagination: { el: '.swiper-pagination', clickable: true },
  navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' },
  breakpoints: { 640: { slidesPerView: 1 }, 768: { slidesPerView: 2 }, 1024: { slidesPerView: 3 } }
});

// SWIPER TESTIMONIALS
const testimonialsSwiper = new Swiper('.testimonials-swiper', {
  slidesPerView: 1,
  spaceBetween: 20,
  loop: true,
  pagination: { el: '.swiper-pagination', clickable: true },
  breakpoints: { 640: { slidesPerView: 1 }, 768: { slidesPerView: 2 } }
});

// SCROLLREVEAL
ScrollReveal({ origin: 'bottom', distance: '50px', duration: 1000, delay: 200, reset: false });
ScrollReveal().reveal('.header__logo, .nav__list', { origin: 'top' });
ScrollReveal().reveal('.home-text, .home-img', { interval: 200 });
ScrollReveal().reveal('.about-content, .projects-swiper, .services-grid, .testimonials-swiper, .contact-container', { interval: 200 });
ScrollReveal().reveal('.project, .testimonial, .service-card', { interval: 150 });
