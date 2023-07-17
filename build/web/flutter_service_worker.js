'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "51d391e8ebc960d345529530c76d4da4",
"assets/assets/images/covers/pk_b2w2.jpg": "875db959e3a11437c07cfe746f210d2b",
"assets/assets/images/covers/pk_bdsp.jpg": "6bd768e1110ad1e992730478a1eb1181",
"assets/assets/images/covers/pk_bw.jpg": "b3d31c863ace1d9f8474c49ed8da0210",
"assets/assets/images/covers/pk_crystal.jpg": "9068042f9e575b2b6ffcc97f172ff854",
"assets/assets/images/covers/pk_dp.jpg": "9938f0f795848274294631bb0d8fa323",
"assets/assets/images/covers/pk_emerald.jpg": "b6bb0fa855991708c047429a6a3e64df",
"assets/assets/images/covers/pk_frlg.jpg": "afab88ea36fc0f76d8b3d0568ea68821",
"assets/assets/images/covers/pk_gs.jpg": "c9ec19ce29fbdf230634795ebe18c0a2",
"assets/assets/images/covers/pk_hgss.jpg": "3e6f40d11d826cc1f4babd1c5b2147b0",
"assets/assets/images/covers/pk_lgpe.jpg": "badd1f66bfdd380cbb4b4b97caf29724",
"assets/assets/images/covers/pk_lpa.jpg": "c128c68f3c52a462426d39d79fff167a",
"assets/assets/images/covers/pk_oras.jpg": "7a1791407f2bd56bd86de9e3848962b8",
"assets/assets/images/covers/pk_platinum.jpg": "efdd474ffac175997868fa704bdc063e",
"assets/assets/images/covers/pk_rb.jpg": "b05a040614f0a074ee1edbf32e1a2df9",
"assets/assets/images/covers/pk_rs.jpg": "76bef53da3de8b448e3c617ae577bb55",
"assets/assets/images/covers/pk_sm.jpg": "e7d17e6d908e58deb3fd3a15a484f5d9",
"assets/assets/images/covers/pk_ss.jpg": "2a8aa046f040a1cc57e1e31dd6797c1a",
"assets/assets/images/covers/pk_sv.jpg": "1997a73a7be26c39d972218c7d97a5d0",
"assets/assets/images/covers/pk_usum.jpg": "288993a72eb722a306dccdfb1a093c44",
"assets/assets/images/covers/pk_xy.jpg": "15fee6503ae24963e67d76452adb3856",
"assets/assets/images/covers/pk_yellow.jpg": "effd153f9799be0788bc18a4910055ad",
"assets/assets/images/dex/001.png": "9ba4d684e64c19af7c99148ac36af46b",
"assets/assets/images/dex/002.png": "28cc8e884bbbf08ac3b44b4013a3d5db",
"assets/assets/images/dex/003.png": "8c37e2ae54a20df159b6706ef5663ff9",
"assets/assets/images/dex/004.png": "9be8f2a81b006e2f8897f1889107d0f7",
"assets/assets/images/dex/005.png": "4e83c7dbbb912257f06b13cc1468f76f",
"assets/assets/images/dex/006.png": "2d32cf3c3042861de658c96052673408",
"assets/assets/images/dex/007.png": "7b9ddf692c6df64d86bbe4e96ef46a83",
"assets/assets/images/dex/008.png": "04cfac8634923b57a079cc4381035686",
"assets/assets/images/dex/009.png": "14aba60b06ced6ea846ad63b6611f524",
"assets/assets/images/dex/010.png": "799de73ed9a4d32ad6c08e7dc8fcfc50",
"assets/assets/images/dex/011.png": "5bc90ea068bdd1162f0bf10a64326fe2",
"assets/assets/images/dex/012.png": "eb6566a45da0d7770ac2e01025b657bd",
"assets/assets/images/dex/013.png": "a36e71da6ec97bf184a71883476152b0",
"assets/assets/images/dex/014.png": "06d3055f204c544a79f3ce6e9103a4dc",
"assets/assets/images/dex/015.png": "7fc54db4c58e2e51f4999ce66c12448a",
"assets/assets/images/dex/016.png": "15ca3e1cc06bcdbc380662f2432008ee",
"assets/assets/images/dex/017.png": "f1972cf117fbc7544f798e0fec399414",
"assets/assets/images/dex/018.png": "b33fccccc3c38657fbf66bda12a7ca90",
"assets/assets/images/dex/019.png": "d21d04d8488e11ee9a04a9d8b3e6573a",
"assets/assets/images/dex/020.png": "5a34e7eeebc70b99bd4d5f7694edb452",
"assets/assets/images/dex/021.png": "f993baa8707a5cc7638c8434b3d8f9e4",
"assets/assets/images/dex/022.png": "2640107a291d1d0b1700a42273c467f8",
"assets/assets/images/dex/023.png": "bd66b4f62115f19d42302758677525b8",
"assets/assets/images/dex/024.png": "44ab0aecdfa80c2df6060ff82a6d067b",
"assets/assets/images/dex/025.png": "53dbfd304766b5858ee6e139646713c7",
"assets/assets/images/dex/026.png": "f3e7b764831b656de7bdb1be1445e766",
"assets/assets/images/dex/027.png": "2c4cebbd67505ea15634b3a81a291b1c",
"assets/assets/images/dex/028.png": "e4e761082a8714e94d3f077f68789712",
"assets/assets/images/dex/029.png": "52f72fbcca315b01a0a8ad447a45b719",
"assets/assets/images/dex/030.png": "9445ac8fb36bd9ceea8359d9fe1f2a50",
"assets/assets/images/dex/031.png": "f1daccbfc13564b867137042466f8d49",
"assets/assets/images/dex/032.png": "f7af82c96ad43f4ea9dc0fedb945a6fd",
"assets/assets/images/dex/033.png": "8ed9ee720a67b8e8254662b0d6f2638a",
"assets/assets/images/dex/034.png": "9f683fa0a3c6bfd182cea5d44a142d20",
"assets/assets/images/dex/035.png": "619637a67aa9ed96927ac7f637e6da29",
"assets/assets/images/dex/036.png": "57be8deeb5c0ce45b69415b0a333f5aa",
"assets/assets/images/dex/037.png": "486cbfa6a683a20b33de46403b220d64",
"assets/assets/images/dex/038.png": "4e358ab74348b29e931c36756d9fe5c4",
"assets/assets/images/dex/039.png": "4f8fa587026cd74989c10629fdbb1cd1",
"assets/assets/images/dex/040.png": "be829108ec350dca18453fec91f7f85f",
"assets/assets/images/dex/041.png": "04bad30757cc64a63f352077c1c38e98",
"assets/assets/images/dex/042.png": "eace8e96fc0edf4fe3f48e80b20e08e3",
"assets/assets/images/dex/043.png": "86123ef18e1f6c91fd15d92fe000e679",
"assets/assets/images/dex/044.png": "558b0d33be00f6fbd605191427d5b632",
"assets/assets/images/dex/045.png": "409c6f4963b8731bce34411d14595421",
"assets/assets/images/dex/046.png": "2a48e7e33f03146e7a4aef9884b63dcd",
"assets/assets/images/dex/047.png": "0874103da2816f92bdc29a4c36939b90",
"assets/assets/images/dex/048.png": "1ccce677bb4980ce2c3e48830120aa69",
"assets/assets/images/dex/049.png": "15dab15b58aa9922321379fa00bd2b3f",
"assets/assets/images/dex/050.png": "b40049947859e633e0467c7c0cfe9f92",
"assets/assets/images/dex/051.png": "579886eaef7bfcfd21add70d3bd04bc2",
"assets/assets/images/dex/052.png": "9a42388be590ee046cc5cd0e57f9aa46",
"assets/assets/images/dex/053.png": "04b6fcae171eeddec445c20f30e51d05",
"assets/assets/images/dex/054.png": "7146ce8a6a916650e3a8b0e8d0e4b9c6",
"assets/assets/images/dex/055.png": "fade82558a72615ae6ff1b617fec91f5",
"assets/assets/images/dex/056.png": "42682daef44bc439c3464dec5eafa673",
"assets/assets/images/dex/057.png": "61e7ab0512af6a444c8413c20eccfc85",
"assets/assets/images/dex/058.png": "2b7a20d6b3d7e5688c6034e0401ead59",
"assets/assets/images/dex/059.png": "d0a8bc53afc614433949f7ee24f7cd00",
"assets/assets/images/dex/060.png": "aca3182e4777a94bba85e4a477dc79ad",
"assets/assets/images/dex/061.png": "46121bfde76640535a7ebc4b6d828815",
"assets/assets/images/dex/062.png": "4ca6f0c317d81a76599b884ee844a9f6",
"assets/assets/images/dex/063.png": "0e98362fd2b0a6bcd579b0918c160c68",
"assets/assets/images/dex/064.png": "fbc1ef4fed7b60445004d25f93ac5878",
"assets/assets/images/dex/065.png": "e1411a251f8b763c4161a924c79c026c",
"assets/assets/images/dex/066.png": "793aacf3d223746732373b145bb803e4",
"assets/assets/images/dex/067.png": "c561388bf7d7f6c4312a85edde46323b",
"assets/assets/images/dex/068.png": "77f1134854221805101f4caf12f81f62",
"assets/assets/images/dex/069.png": "953f6e72014ac744e54815991075b5e3",
"assets/assets/images/dex/070.png": "8b080e5620605a08d19b3506c4121dff",
"assets/assets/images/dex/071.png": "3d883ce072ae49f3dcaad96ac1032fdb",
"assets/assets/images/dex/072.png": "ce9fd51f046cae707f95a2614f873028",
"assets/assets/images/dex/073.png": "5e3c3ef7382339f1e41a69513b41ba73",
"assets/assets/images/dex/074.png": "e29b28dba4748a0c4a448bf51bfdd91d",
"assets/assets/images/dex/075.png": "930d2143ea662bc6f8808fab76265d76",
"assets/assets/images/dex/076.png": "8663515eec70748e291f7f60a5f27fac",
"assets/assets/images/dex/077.png": "68f56a019e897f1514ca7ef17e191b38",
"assets/assets/images/dex/078.png": "333ba14a7324fe83e8db4d864f26a7c3",
"assets/assets/images/dex/079.png": "5bd4b88f3d184bfe81e793870f87b7a5",
"assets/assets/images/dex/080.png": "2c164a7f6efa6214e0ca2c9c06d32d6b",
"assets/assets/images/dex/081.png": "18e3d1efa4d60d6e853a7ccad9a6d5f5",
"assets/assets/images/dex/082.png": "69c97d23845bacd4df5585badf337718",
"assets/assets/images/dex/083.png": "092b05f340e628fad04495edd691923a",
"assets/assets/images/dex/084.png": "ca4490e0f73f2c5e011013ba82e5d998",
"assets/assets/images/dex/085.png": "102284a9735e8a04624565a6336aded1",
"assets/assets/images/dex/086.png": "f677130996bc20f061388f985cd72117",
"assets/assets/images/dex/087.png": "ed7636bcb364608428ef281aabc82f6b",
"assets/assets/images/dex/088.png": "07e555e711e2d26e9d55719c3b54b3a2",
"assets/assets/images/dex/089.png": "e5033856e70724dbda5a11303b908abd",
"assets/assets/images/dex/090.png": "221c435f654b9580227ed8f1c1b89f6e",
"assets/assets/images/dex/091.png": "cbc8e5256e8b2205e1e8940c6c940cb1",
"assets/assets/images/dex/092.png": "0d5af8ce19ba2617f00148668746f6da",
"assets/assets/images/dex/093.png": "b93f8448e088707daaa6647976baa9c8",
"assets/assets/images/dex/094.png": "8a2c3ce0cfd5c38bb0ebd086f3a48741",
"assets/assets/images/dex/095.png": "781e3c879c64d8fcaa42254c14e90601",
"assets/assets/images/dex/096.png": "b0ea7aa75d764ac22d0f8d0acff33d1d",
"assets/assets/images/dex/097.png": "3dc48878b556cf8a1f882a4dbf4a2d26",
"assets/assets/images/dex/098.png": "4923be70a6a7a8a1fe0e45926e60157f",
"assets/assets/images/dex/099.png": "0797b23782d8c26eb1c642f2c1cdeb61",
"assets/assets/images/dex/100.png": "028f6bd806ae14844a778a944c2435a8",
"assets/assets/images/dex/101.png": "c8abfb856da2fb4a3fd5f771018dac4c",
"assets/assets/images/dex/102.png": "cd4d13f4b37d9772a6f3f560cc574a5b",
"assets/assets/images/dex/103.png": "7b70047162d7031484cca88794d97195",
"assets/assets/images/dex/104.png": "799e0e87dae2c7a9985990b2424a5b82",
"assets/assets/images/dex/105.png": "f16f37aba434c99c46675e041e8447d0",
"assets/assets/images/dex/106.png": "0fabb4e0eb95aa1c9e129ef79e380e02",
"assets/assets/images/dex/107.png": "8fb72d6ec729d3029eddde4ed1a3b2c9",
"assets/assets/images/dex/108.png": "df1ee9be9e884858698fe55a297c3eb8",
"assets/assets/images/dex/109.png": "9773bf20bfa2d64e04b5367c4171f7fb",
"assets/assets/images/dex/110.png": "c30088fc328818b6888550be1f1fc36f",
"assets/assets/images/dex/111.png": "81dd809541ff661c5d75f928354d5382",
"assets/assets/images/dex/112.png": "58abe48f497dbff64dcdb39c2d42d207",
"assets/assets/images/dex/113.png": "e2e42b57979d1c86dd0deb9b4bf5ecd5",
"assets/assets/images/dex/114.png": "ce22d1c75349cc44fc8b6392f7b5d2b8",
"assets/assets/images/dex/115.png": "a33dca666e6aa7a1f4f3963b0097d461",
"assets/assets/images/dex/116.png": "a69ccfde7b7be6a0f85ae4cfb6a2af36",
"assets/assets/images/dex/117.png": "4e643b87406dd9264e7e0e21352abaf2",
"assets/assets/images/dex/118.png": "e7271a2a85d55b3e7aa46ed0a05a070f",
"assets/assets/images/dex/119.png": "a56ed3e40e6a592824f12b26dc844d55",
"assets/assets/images/dex/120.png": "bed11b75b421a7a4222770606a7acf1a",
"assets/assets/images/dex/121.png": "60bb4d45cf34b3be8b3e5f02a93720d4",
"assets/assets/images/dex/122.png": "ee3250d4532dbf48b84ac537a774b592",
"assets/assets/images/dex/123.png": "a1aca2ec6703b2dbedd4158c8d7f5931",
"assets/assets/images/dex/124.png": "a6b627161126139aa65b82f4d9eac8e8",
"assets/assets/images/dex/125.png": "c62be78fed3312f7adca8c79b0b6613f",
"assets/assets/images/dex/126.png": "f0509a75aa98389d22eb9011f54d9465",
"assets/assets/images/dex/127.png": "c93c75e1afa25fc5da06e767e7ca3720",
"assets/assets/images/dex/128.png": "837881a436eabbd8bdb308f825bd6df5",
"assets/assets/images/dex/129.png": "dbc8364834950405f52eb2cb24887023",
"assets/assets/images/dex/130.png": "55afe49b42cd5f780ba9cc707cde8264",
"assets/assets/images/dex/131.png": "f26ee6048a5f85e804cdc9c0a2e12e06",
"assets/assets/images/dex/132.png": "c42a37de31627293cc79ef00f34fffa5",
"assets/assets/images/dex/133.png": "c157545ab985be295c9566b427102231",
"assets/assets/images/dex/134.png": "57d04bfe5867fc0a8e2b55000e7e5ee4",
"assets/assets/images/dex/135.png": "e0737bed91857347aa412c9a0fde3a22",
"assets/assets/images/dex/136.png": "6a60d22641e7452be7bcc4461a3a6e5f",
"assets/assets/images/dex/137.png": "b4871fb5081babaaf682d548a7218065",
"assets/assets/images/dex/138.png": "bea5ba6c71117de971d9fad5a084aa7d",
"assets/assets/images/dex/139.png": "188ec81e1eda42517e1171f0136f9941",
"assets/assets/images/dex/140.png": "c2fa95eb186566e2ee20c07bdf60a7a2",
"assets/assets/images/dex/141.png": "09084f207ff41bdfb5984fbd57752361",
"assets/assets/images/dex/142.png": "c647ffc193cae72d653464cf49400987",
"assets/assets/images/dex/143.png": "7c3efbfeea61505167b89cac5640a3c3",
"assets/assets/images/dex/144.png": "b02b6fb0a4e42619e6c7290d111a4cb9",
"assets/assets/images/dex/145.png": "39effe4839775eb7f586078a03bc2aa3",
"assets/assets/images/dex/146.png": "7e64338e570d1ee01674ec61d66b1663",
"assets/assets/images/dex/147.png": "c19cc8010f6d040d7fc4a076a9504733",
"assets/assets/images/dex/148.png": "bde38f317d9bd8512ef74d27629d0895",
"assets/assets/images/dex/149.png": "d6330a9d746c7a66f2eb27cec182ea43",
"assets/assets/images/dex/150.png": "0c7aa137c662e4a53500eefd342f8968",
"assets/assets/images/dex/151.png": "19c9ebf329bfa43488ebf2f930e42284",
"assets/assets/images/other/pkdex.png": "024bbe0048fd39a3b186cf11c139cbf9",
"assets/assets/images/other/pk_wp_1.jpg": "8370c5a817676a4c76d8df8b1ad4ab27",
"assets/assets/images/other/pk_wp_2.jpg": "938722a957172f5ca3c2866cc14af72f",
"assets/assets/images/other/pk_wp_3.jpg": "2caf25c5aa629be0ee7903caf3ae3d22",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "fc45d800f02e1c8a5971d4b710ce2a26",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "81e28720fd90377873ad80c29f681d45",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "111e26da3647d9ca7b6290db1c2b8438",
"/": "111e26da3647d9ca7b6290db1c2b8438",
"main.dart.js": "1f7835e1516eaf37d9574dd8b77c468d",
"manifest.json": "7231c3b47e6f5f44db5636be4215e291",
"version.json": "f380340d08e0a601d54b044d0dfb6897"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
