// Service Worker for Westmark Talent Group - Production Optimized
const CACHE_NAME = 'westmark-v1';
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
  './manifest.json'
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
