// Service Worker for Westmark Talent Group - Enhanced Performance
const CACHE_NAME = 'westmark-v3';
const STATIC_CACHE = 'westmark-static-v3';
const DYNAMIC_CACHE = 'westmark-dynamic-v3';

const urlsToCache = [
  './',
  './index.html',
  './clients.html',
  './contact-us.html',
  './logo.html',
  './assets/css/optimized.css',
  './assets/theme/css/style.css',
  './assets/bootstrap/css/bootstrap.min.css',
  './assets/bootstrap/css/bootstrap-grid.min.css',
  './assets/bootstrap/css/bootstrap-reboot.min.css',
  './assets/theme/js/script.js',
  './assets/theme/js/error-handling.js',
  './assets/js/performance-monitor.js',
  './manifest.json',
  './linkedin.webp',
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

// Install event - cache resources with enhanced strategy
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(STATIC_CACHE)
      .then(cache => {
        return cache.addAll(urlsToCache);
      })
      .then(() => {
        return self.skipWaiting();
      })
      .catch(error => {
        // Silent fail in production
        if (self.location.hostname === 'localhost' || self.location.hostname === '127.0.0.1') {
          console.error('Service Worker install failed:', error);
        }
      })
  );
});

// Fetch event - enhanced caching strategy
self.addEventListener('fetch', event => {
  // Skip non-GET requests
  if (event.request.method !== 'GET') return;
  
  // Skip external requests
  if (!event.request.url.startsWith(self.location.origin)) return;
  
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Return cached version if available
        if (response) {
          return response;
        }
        
        // Fetch from network and cache for future use
        return fetch(event.request)
          .then(fetchResponse => {
            // Don't cache non-successful responses
            if (!fetchResponse || fetchResponse.status !== 200 || fetchResponse.type !== 'basic') {
              return fetchResponse;
            }
            
            // Clone the response
            const responseToCache = fetchResponse.clone();
            
            // Cache in dynamic cache
            caches.open(DYNAMIC_CACHE)
              .then(cache => {
                cache.put(event.request, responseToCache);
              });
            
            return fetchResponse;
          })
          .catch(() => {
            // Return offline page for navigation requests
            if (event.request.destination === 'document') {
              return caches.match('./index.html');
            }
          });
      })
  );
});

// Activate event - clean up old caches and claim clients
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== STATIC_CACHE && cacheName !== DYNAMIC_CACHE) {
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => {
      return self.clients.claim();
    })
  );
});

// Background sync for offline form submissions
self.addEventListener('sync', event => {
  if (event.tag === 'background-sync') {
    event.waitUntil(doBackgroundSync());
  }
});

// Push notifications
self.addEventListener('push', event => {
  if (event.data) {
    const data = event.data.json();
    const options = {
      body: data.body,
      icon: '/assets/images/westmark-logo-128x62-1.webp',
      badge: '/assets/images/westmark-logo-128x62-1.webp',
      vibrate: [100, 50, 100],
      data: {
        dateOfArrival: Date.now(),
        primaryKey: data.primaryKey
      },
      actions: [
        {
          action: 'explore',
          title: 'View Jobs',
          icon: '/assets/images/westmark-logo-128x62-1.webp'
        },
        {
          action: 'close',
          title: 'Close',
          icon: '/assets/images/westmark-logo-128x62-1.webp'
        }
      ]
    };
    
    event.waitUntil(
      self.registration.showNotification(data.title, options)
    );
  }
});

// Background sync function
function doBackgroundSync() {
  // Handle offline form submissions or other background tasks
  return Promise.resolve();
}
