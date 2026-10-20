/**
 * Delish House - Platform UMKM Kuliner Berbasis AI
 * Interaction Script
 */

document.addEventListener('DOMContentLoaded', () => {
  // 1. Navbar Sticky & Scroll Effect
  const navbar = document.getElementById('navbar');
  const backToTopBtn = document.getElementById('backToTopBtn');

  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY;

    if (scrollY > 30) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }

    if (scrollY > 400) {
      backToTopBtn.classList.add('show');
    } else {
      backToTopBtn.classList.remove('show');
    }
  });

  // Back to Top Click
  if (backToTopBtn) {
    backToTopBtn.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // 2. Mobile Hamburger Menu Toggle
  const hamburgerBtn = document.getElementById('hamburgerBtn');
  const navMenu = document.getElementById('navMenu');

  if (hamburgerBtn && navMenu) {
    hamburgerBtn.addEventListener('click', (e) => {
      e.stopPropagation();
      navMenu.classList.toggle('mobile-open');
      hamburgerBtn.classList.toggle('active');
    });

    // Close mobile menu when a nav link is clicked
    const navLinks = navMenu.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
      link.addEventListener('click', () => {
        navMenu.classList.remove('mobile-open');
        hamburgerBtn.classList.remove('active');
      });
    });

    // Close mobile/tablet menu when clicking outside
    document.addEventListener('click', (e) => {
      if (navMenu.classList.contains('mobile-open')) {
        if (!navMenu.contains(e.target) && !hamburgerBtn.contains(e.target)) {
          navMenu.classList.remove('mobile-open');
          hamburgerBtn.classList.remove('active');
        }
      }
    });
  }

  // 3. Active Nav Link on Scroll
  const sections = document.querySelectorAll('section[id], footer[id]');
  const navLinks = document.querySelectorAll('.nav-link');

  window.addEventListener('scroll', () => {
    let currentSection = '';
    const scrollPosition = window.scrollY + 200;

    sections.forEach(section => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
        currentSection = section.getAttribute('id');
      }
    });

    navLinks.forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === `#${currentSection}`) {
        link.classList.add('active');
      }
    });
  });

  // 4. Modal Pendaftaran UMKM & Login Handling
  const registerModal = document.getElementById('registerModal');
  const modalCloseBtn = document.getElementById('modalCloseBtn');
  const loginModal = document.getElementById('loginModal');
  const loginModalCloseBtn = document.getElementById('loginModalCloseBtn');
  const btnNavLogin = document.getElementById('btnNavLogin');
  const switchRegisterLink = document.getElementById('switchRegisterLink');

  const btnNavRegister = document.getElementById('btnNavRegister');
  const btnHeroRegister = document.getElementById('btnHeroRegister');
  const btnSolutionStart = document.getElementById('btnSolutionStart');
  const btnCtaRegister = document.getElementById('btnCtaRegister');

  const openRegisterModal = (e) => {
    if (e) e.preventDefault();
    if (loginModal) loginModal.classList.remove('active');
    if (registerModal) registerModal.classList.add('active');
  };

  const closeRegisterModal = () => {
    if (registerModal) registerModal.classList.remove('active');
  };

  const openLoginModal = (e) => {
    if (e) e.preventDefault();
    if (registerModal) registerModal.classList.remove('active');
    if (loginModal) loginModal.classList.add('active');
  };

  const closeLoginModal = () => {
    if (loginModal) loginModal.classList.remove('active');
  };

  if (btnNavRegister) btnNavRegister.addEventListener('click', openRegisterModal);
  if (btnHeroRegister) btnHeroRegister.addEventListener('click', openRegisterModal);
  if (btnSolutionStart) btnSolutionStart.addEventListener('click', openRegisterModal);
  if (btnCtaRegister) btnCtaRegister.addEventListener('click', openRegisterModal);
  const btnCtaDaftar = document.getElementById('btnCtaDaftar');
  if (btnCtaDaftar) btnCtaDaftar.addEventListener('click', openRegisterModal);
  if (switchRegisterLink) switchRegisterLink.addEventListener('click', openRegisterModal);

  const btnKelolaDaftar = document.getElementById('btnKelolaDaftar');
  const btnKelolaMore = document.getElementById('btnKelolaMore');
  if (btnKelolaDaftar) btnKelolaDaftar.addEventListener('click', openRegisterModal);
  if (btnKelolaMore) {
    btnKelolaMore.addEventListener('click', () => {
      const petaSection = document.getElementById('peta-kuliner');
      if (petaSection) {
        petaSection.scrollIntoView({ behavior: 'smooth' });
      }
    });
  }

  if (btnNavLogin) btnNavLogin.addEventListener('click', openLoginModal);

  const navLinkUmkm = document.getElementById('navLinkUmkm');
  if (navLinkUmkm) navLinkUmkm.addEventListener('click', openRegisterModal);

  // Mobile / Tablet Drawer Buttons
  const btnNavLoginMenu = document.getElementById('btnNavLoginMenu');
  const btnNavRegisterMenu = document.getElementById('btnNavRegisterMenu');
  if (btnNavLoginMenu) {
    btnNavLoginMenu.addEventListener('click', (e) => {
      openLoginModal(e);
      if (navMenu) navMenu.classList.remove('mobile-open');
      if (hamburgerBtn) hamburgerBtn.classList.remove('active');
    });
  }
  if (btnNavRegisterMenu) {
    btnNavRegisterMenu.addEventListener('click', (e) => {
      openRegisterModal(e);
      if (navMenu) navMenu.classList.remove('mobile-open');
      if (hamburgerBtn) hamburgerBtn.classList.remove('active');
    });
  }

  if (modalCloseBtn) modalCloseBtn.addEventListener('click', closeRegisterModal);
  if (loginModalCloseBtn) loginModalCloseBtn.addEventListener('click', closeLoginModal);

  if (registerModal) {
    registerModal.addEventListener('click', (e) => {
      if (e.target === registerModal) {
        closeRegisterModal();
      }
    });
  }

  if (loginModal) {
    loginModal.addEventListener('click', (e) => {
      if (e.target === loginModal) {
        closeLoginModal();
      }
    });
  }

  // Close with Escape key
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      closeRegisterModal();
      closeLoginModal();
    }
  });

  // 5. Form Submission & Toast Notification
  const partnerForm = document.getElementById('partnerRegisterForm');
  const loginForm = document.getElementById('loginForm');
  const toast = document.getElementById('toastNotification');

  const showToast = (message) => {
    if (!toast) return;
    if (message) {
      const toastMsg = toast.querySelector('.toast-msg');
      if (toastMsg) toastMsg.textContent = message;
    }
    toast.classList.add('show');
    setTimeout(() => {
      toast.classList.remove('show');
    }, 4500);
  };

  if (partnerForm) {
    partnerForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const vendorName = document.getElementById('vendorName')?.value || 'Mitra';
      closeRegisterModal();
      partnerForm.reset();
      showToast(`Terima kasih! Pendaftaran usaha "${vendorName}" berhasil kami terima.`);
    });
  }

  if (loginForm) {
    loginForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const userEmail = document.getElementById('loginEmail')?.value || 'Pengguna';
      closeLoginModal();
      loginForm.reset();
      showToast(`Selamat datang kembali! Anda berhasil masuk sebagai ${userEmail}.`);
    });
  }

  // Newsletter Form Submission
  const newsletterForm = document.getElementById('newsletterForm');
  const newsletterEmail = document.getElementById('newsletterEmail');
  if (newsletterForm && newsletterEmail) {
    newsletterForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const email = newsletterEmail.value.trim();
      if (email) {
        showToast(`Terima kasih! Kami akan mengirimkan update kuliner ke ${email}.`);
        newsletterForm.reset();
      }
    });
  }

  // 5B. Navbar Search Button & Hero Search Form
  const navSearchBtn = document.getElementById('navSearchBtn');
  const heroSearchInput = document.getElementById('heroSearchInput');
  const heroSearchForm = document.getElementById('heroSearchForm');

  if (navSearchBtn && heroSearchInput) {
    navSearchBtn.addEventListener('click', () => {
      heroSearchInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
      setTimeout(() => {
        heroSearchInput.focus();
      }, 500);
    });
  }

  if (heroSearchForm && heroSearchInput) {
    heroSearchForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const query = heroSearchInput.value.trim();
      const category = document.getElementById('heroCategorySelect')?.value || 'Semua';
      if (query) {
        showToast(`Mencari "${query}" dalam kategori ${category}...`);
      } else {
        showToast(`Menampilkan semua kuliner rekomendasi...`);
      }
    });
  }

  // 5B. Interactive Category Tabs & Slider
  const categoryTabBtns = document.querySelectorAll('.category-tab-btn');
  const foodCards = document.querySelectorAll('.popular-food-card');
  const categoryTrack = document.getElementById('categoryCardsTrack');
  const categoryNextBtn = document.getElementById('popularFoodNextBtn');
  const categoryPrevBtn = document.getElementById('popularFoodPrevBtn');

  // Category Tab Filtering
  if (categoryTabBtns.length && foodCards.length) {
    categoryTabBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        categoryTabBtns.forEach(b => {
          b.classList.remove('active');
          b.setAttribute('aria-selected', 'false');
        });
        btn.classList.add('active');
        btn.setAttribute('aria-selected', 'true');

        const selectedCat = btn.getAttribute('data-category');

        foodCards.forEach(card => {
          const cardCat = card.getAttribute('data-category');
          if (selectedCat === 'semua' || cardCat === selectedCat) {
            card.style.display = 'flex';
          } else {
            card.style.display = 'none';
          }
        });

        if (categoryTrack) {
          categoryTrack.scrollTo({ left: 0, behavior: 'smooth' });
        }
      });
    });
  }

  // Category Slider Scroll Controls
  if (categoryTrack && categoryNextBtn && categoryPrevBtn) {
    categoryNextBtn.addEventListener('click', () => {
      categoryTrack.scrollBy({ left: 260, behavior: 'smooth' });
    });

    categoryPrevBtn.addEventListener('click', () => {
      categoryTrack.scrollBy({ left: -260, behavior: 'smooth' });
    });

    categoryTrack.addEventListener('scroll', () => {
      const scrollLeft = categoryTrack.scrollLeft;
      const maxScroll = categoryTrack.scrollWidth - categoryTrack.clientWidth;

      if (scrollLeft > 20) {
        categoryPrevBtn.style.display = 'flex';
      } else {
        categoryPrevBtn.style.display = 'none';
      }

      if (scrollLeft >= maxScroll - 20) {
        categoryNextBtn.style.display = 'none';
      } else {
        categoryNextBtn.style.display = 'flex';
      }
    });
  }

  // Food Card Quick Click Toast / Interaction
  foodCards.forEach(card => {
    card.addEventListener('click', () => {
      const title = card.querySelector('.food-card-title')?.textContent || 'Kuliner';
      showToast(`Membuka menu "${title}"...`);
    });
  });

  // 6. Interactive Demo Buttons
  const btnSolutionSample = document.getElementById('btnSolutionSample');
  const btnCtaExplore = document.getElementById('btnCtaExplore');

  if (btnSolutionSample) {
    btnSolutionSample.addEventListener('click', () => {
      const featureSection = document.getElementById('fitur');
      if (featureSection) {
        featureSection.scrollIntoView({ behavior: 'smooth' });
      }
    });
  }

  if (btnCtaExplore) {
    btnCtaExplore.addEventListener('click', () => {
      const problemSection = document.getElementById('solusi');
      if (problemSection) {
        problemSection.scrollIntoView({ behavior: 'smooth' });
      }
    });
  }

  // 7. Stat Counter Animation on Scroll
  const statNumbers = document.querySelectorAll('.stat-number[data-target]');
  let hasAnimatedStats = false;

  const animateCounters = () => {
    statNumbers.forEach(stat => {
      const target = +stat.getAttribute('data-target');
      const duration = 1800; // ms
      const stepTime = 30;
      const totalSteps = duration / stepTime;
      const increment = target / totalSteps;
      let current = 0;

      const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
          clearInterval(timer);
          if (target === 10000) {
            stat.textContent = '10.000+';
          } else {
            stat.textContent = `${target}+`;
          }
        } else {
          const displayVal = Math.floor(current);
          if (target >= 1000) {
            stat.textContent = `${displayVal.toLocaleString('id-ID')}+`;
          } else {
            stat.textContent = `${displayVal}+`;
          }
        }
      }, stepTime);
    });
  };

  const statsSection = document.getElementById('statistik');
  if (statsSection) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting && !hasAnimatedStats) {
          hasAnimatedStats = true;
          animateCounters();
        }
      });
    }, { threshold: 0.3 });

    observer.observe(statsSection);
  }
});
