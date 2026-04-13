# Currency Converter App

## 📱 Overview

A Flutter-based Currency Converter application that fetches exchange rates, caches them locally, and allows users to perform conversions efficiently with offline support.

---

# 🚀 How to Build & Run the Project

## 1. Clone the repository

```bash
git clone <your-repo-url>
cd currency_convertor_app
```

## 2. Install dependencies

```bash
flutter pub get
```

## 3. Generate required files (Freezed & Hive)

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 4. Run the app

```bash
flutter run
```

---

# 🖼️ Image Loader Library

## ✅ Used Library: `cached_network_image`

### ✔ Why this library?

* **Automatic caching**: Stores downloaded images locally, reducing network calls.
* **Performance optimized**: Prevents unnecessary reloads during widget rebuilds.
* **Placeholder & error handling**: Easily display loaders or fallback UI.
* **Smooth UX**: Improves scrolling performance in lists.

### 📌 Justification

In this app, country flags (or currency-related images) are frequently displayed. Using `cached_network_image` ensures:

* Faster UI rendering
* Reduced API/image calls
* Better user experience in low-network conditions

---

# 🗄️ Database Used

## ✅ Used Database: Hive

### ✔ Why Hive?

* **Lightweight & fast**: Uses binary storage → faster than JSON parsing.
* **No SQL needed**: Simple key-value storage.
* **Great for caching**: Ideal for storing API responses like currency rates.
* **Offline-first support**: Enables app usage without internet after first fetch.
* **Type-safe with adapters**: Works seamlessly with models (especially with Freezed).

---

## 📌 Justification

The app deals with:

* A **list of currency rates**
* Frequent **read operations**
* Minimal need for complex queries

Hive is the best fit because:

* It handles lists of objects efficiently
* Eliminates the need for heavy database solutions like SQLite
* Provides excellent performance for caching API data

---

# 🧠 Architecture Overview

```
Remote API → Hive (Local Cache) → Cubit (State Management) → UI
```

---

# ⚡ Key Features

* Fetch currency rates from API
* Cache data locally using Hive
* Offline support after first load
* Fast currency conversion without repeated API calls
* Clean architecture with separation of concerns

---

# 🛠️ Tech Stack

* Flutter
* Bloc / Cubit (State Management)
* Hive (Local Database)
* Freezed (Immutable Models)
* Dio (Networking)
* Cached Network Image (Image Caching)

---

# 📌 Notes

* API is called **only once**, then data is served from local cache.
* Conversion is handled **locally** for better performance.
* The project follows **clean architecture principles**.

---

# 🔥 Future Improvements

* Cache expiration strategy (e.g., refresh every 24h)
* Currency search feature
* Swap currencies functionality
* UI animations for conversion results

---

## 👨‍💻 Author

Kareem Mohamed
