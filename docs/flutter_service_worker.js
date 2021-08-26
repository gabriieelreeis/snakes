'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "bb1bea8043569b4067a0b0edd679c46c",
"assets/assets/dado-1-1.png": "fd206855f1e3c441874684f488bd85cb",
"assets/assets/dado-1-2.png": "a65aab7ca7345cdf64ef7e70e2417a31",
"assets/assets/dado-1-3.png": "4440fb5a67f170d94ddffba5b2e492bd",
"assets/assets/dado-1-4.png": "74f26d0b28522f3f2f92636fd7d2eca6",
"assets/assets/dado-2-1.png": "d2774d867e6235c574af2bb2f5edd214",
"assets/assets/dado-2-2.png": "5843a4619b8199117aa8b549b11cca02",
"assets/assets/dado-2-3.png": "976ab90f4dad8ae71ab907ccf3f56f48",
"assets/assets/dado-2-4.png": "c77c77f6ed13bc0b03865c51ad1fc57d",
"assets/assets/dado-3-1.png": "a85eb4e5717af59a7e5e40fb0628b683",
"assets/assets/dado-3-2.png": "ea949beedb7a614df2cb44ee882ad5d3",
"assets/assets/dado-3-3.png": "20f0386401031ea32aed6529ab6010b1",
"assets/assets/dado-3-4.png": "29a3e637c211e0de8ac1f570b661901e",
"assets/assets/dado-4-1.png": "f8cbaad513cacd60628f70266beda26c",
"assets/assets/dado-4-2.png": "485b882e0009b052115da9f010a8db3f",
"assets/assets/dado-4-3.png": "bfa8f46648d806bdfb94b5d5576903ab",
"assets/assets/dado-4-4.png": "cb3114ce9629b4bcbdb8525a490f07d6",
"assets/assets/dado-5-1.png": "c503c84aed4f6d5bae04679243686443",
"assets/assets/dado-5-2.png": "cd47ba02abafe26aca863e9e51313290",
"assets/assets/dado-5-3.png": "edb79135b5f59af48b5817406a941dce",
"assets/assets/dado-5-4.png": "b89775df4adeb476bef0b5aa47a2192a",
"assets/assets/dado-6-1.png": "6881d88adb78bc6748eaab0f7cec2ce4",
"assets/assets/dado-6-2.png": "6ba636e953be2d48113efc4d3a0294c0",
"assets/assets/dado-6-3.png": "cb363605f330504d479d58c21fa820d3",
"assets/assets/dado-6-4.png": "7e6e7381b91c46d6622a847bd01858c4",
"assets/assets/snaker-ladders.png": "d0cf0c156a7886a0e37afc371431487c",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "403d17c71a4cff2dc694f527dc4babdf",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "f5c5f00435dacd06d6782df14c0a3507",
"/": "f5c5f00435dacd06d6782df14c0a3507",
"main.dart.js": "b6ba0c10732e08f36ec38567ac631f6a",
"manifest.json": "8beb638773273faa3e5a0ff1afc02e46",
"version.json": "98797cad1c8a239e522a69b36d4912cf"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
