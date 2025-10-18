// Service Worker for Westmark Talent Group - Production Optimized
const CACHE_NAME = 'westmark-v2';
const urlsToCache = [
  './',
  './index.html',
  './clients.html',
  './contact-us.html',
  './logo.html',
  './assets/theme/css/style.css',
  './assets/bootstrap/css/bootstrap.min.css',
  './assets/theme/js/script.js',
  './assets/theme/js/error-handling.js',
  './manifest.json',
  // WebP images for better performance
  './assets/images/architect-engineer-construction-workers-shaking-600nw-1439150765-600x400.webp',
  './assets/images/pexels-apasaric-1437493-2000x1333.webp',
  './assets/images/pexels-expect-best-79873-323780-742x478.webp',
  './assets/images/pexels-pixabay-259588-742x494.webp',
  './assets/images/pexels-sevenstormphotography-439416-742x557.webp',
  './assets/images/photo-1567954970774-58d6aa6c50dc-1.webp',
  './assets/images/screenshot202025-06-0220at207.49.36e280afpm-794x488.webp',
  './assets/images/westmark-logo-128x62-1.webp'
];

// Install event - cache resources
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        return cache.addAll(urlsToCache);
      })
      .catch(error => {
        // Silent fail in production
        if (self.location.hostname === 'localhost' || self.location.hostname === '127.0.0.1') {
          console.error('Service Worker install failed:', error);
        }
      })
  );
});

// Fetch event - serve from cache when possible
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Return cached version or fetch from network
        return response || fetch(event.request);
      })
      .catch(error => {
        // Silent fail in production
        if (self.location.hostname === 'localhost' || self.location.hostname === '127.0.0.1') {
          console.error('Service Worker fetch failed:', error);
        }
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
