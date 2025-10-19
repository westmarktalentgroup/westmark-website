// Service Worker for Westmark Talent Group - Enhanced Performance
const CACHE_NAME = 'westmark-v4';
const STATIC_CACHE = 'westmark-static-v4';
const DYNAMIC_CACHE = 'westmark-dynamic-v4';

const urlsToCache = [
  './',
  './index.html',
  './clients.html',
  './contact-us.html',
  './logo.html',
  './assets/css/optimized.css',
  './assets/js/consolidated.js',
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
        console.log('Service Worker: Static cache installed');
        return self.skipWaiting();
      })
      .catch(error => {
        console.error('Service Worker: Cache installation failed', error);
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys()
      .then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheName !== STATIC_CACHE && cacheName !== DYNAMIC_CACHE) {
              console.log('Service Worker: Deleting old cache', cacheName);
              return caches.delete(cacheName);
            }
          })
        );
      })
      .then(() => {
        console.log('Service Worker: Activated');
        return self.clients.claim();
      })
  );
});

// Fetch event - serve from cache with network fallback
self.addEventListener('fetch', event => {
  const { request } = event;
  const url = new URL(request.url);

  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }

  // Skip external requests
  if (url.origin !== location.origin) {
    return;
  }

  event.respondWith(
    caches.match(request)
      .then(response => {
        // Return cached version if available
        if (response) {
          return response;
        }

        // Otherwise fetch from network
        return fetch(request)
          .then(response => {
            // Don't cache non-successful responses
            if (!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }

            // Clone the response
            const responseToCache = response.clone();

            // Cache the response
            caches.open(DYNAMIC_CACHE)
              .then(cache => {
                cache.put(request, responseToCache);
              });

            return response;
          })
          .catch(error => {
            console.error('Service Worker: Fetch failed', error);
            
            // Return offline page for navigation requests
            if (request.mode === 'navigate') {
              return caches.match('./index.html');
            }
            
            throw error;
          });
      })
  );
});

// Background sync for form submissions
self.addEventListener('sync', event => {
  if (event.tag === 'background-sync') {
    event.waitUntil(
      // Handle background sync logic here
      console.log('Service Worker: Background sync triggered')
    );
  }
});

// Push notifications (if needed in future)
self.addEventListener('push', event => {
  if (event.data) {
    const data = event.data.json();
    const options = {
      body: data.body,
      icon: './assets/images/westmark-logo-128x62-1.webp',
      badge: './assets/images/westmark-logo-128x62-1.webp',
      vibrate: [100, 50, 100],
      data: {
        dateOfArrival: Date.now(),
        primaryKey: data.primaryKey
      },
      actions: [
        {
          action: 'explore',
          title: 'View Details',
          icon: './assets/images/westmark-logo-128x62-1.webp'
        },
        {
          action: 'close',
          title: 'Close',
          icon: './assets/images/westmark-logo-128x62-1.webp'
        }
      ]
    };

    event.waitUntil(
      self.registration.showNotification(data.title, options)
    );
  }
});

// Notification click handler
self.addEventListener('notificationclick', event => {
  event.notification.close();

  if (event.action === 'explore') {
    event.waitUntil(
      clients.openWindow('/')
    );
  }
});

console.log('Service Worker: Loaded successfully');