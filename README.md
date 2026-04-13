# Currency Converter App

## 📱 Overview

A Flutter-based Currency Converter application that fetches exchange rates, caches them locally, and allows users to perform conversions efficiently with offline support.

---

# 🚀 How to Build & Run the Project

## 1. Clone the repository


git clone https://github.com/Kareemm0/currency_convertor_app
cd currency_convertor_app


## 2. Install dependencies
flutter pub get



## 3. Generate required files (Freezed & Hive)


dart run build_runner build 


## 4. Run the app

flutter run

# 🖼️ Image Loader Library

## ✅ Used : flutter_svg with SvgPicture.string()

### ✔ Why this ?

SVG support: Renders vector-based flag images without quality loss
Direct string parsing: Handles SVG data directly from API responses
Memory efficient: Vector graphics consume less memory than raster images
Scalable: Flags look crisp on any screen size or resolution
No network overhead: SVG strings are delivered with API responses, eliminating additional network requests

### 📌 Justification


In this app, country flags are delivered as SVG string data directly from the API (not as image URLs). Using flutter_svg with SvgPicture.string() allows the app to:

Display flags immediately without extra network calls
Parse and render SVG content efficiently
Maintain high-quality visuals on all devices
Reduce bandwidth usage by eliminating separate image downloads

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


Remote API → Hive (Local Cache) → Cubit (State Management) → UI




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
