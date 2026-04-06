# 💾 macOS JSON File I/O — SwiftUI Notes App

A macOS SwiftUI notes app demonstrating how to persist data by reading and writing JSON files to the app's documents directory — no SwiftData or Core Data required.

---

## 🤔 What this is

MacOS-JSON-File-I-O shows how to build a macOS notes app where data survives app restarts by encoding it as JSON and saving it to disk using `JSONEncoder` and `JSONDecoder`. It's the foundational persistence pattern — understanding how to read and write local files — before reaching for heavier frameworks.

## ✅ Why you'd use it

- **`JSONEncoder` / `JSONDecoder`** — serialize and deserialize `Codable` model objects to and from disk
- **Documents directory** — shows how to locate the app sandbox's persistent storage path with `FileManager`
- **No framework overhead** — pure Swift file I/O, no SwiftData, Core Data, or third-party dependencies
- **`Note` Codable model** — simple struct as the data layer, easy to extend
- **Foundation for progression** — understand manual persistence before graduating to SwiftData

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/sSAPsakD5l0)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/MacOS-JSON-File-I-O.git
cd MacOS-JSON-File-I-O
```

### 2. Open in Xcode
Double-click `MacOSNotesAppPersistence.xcodeproj`.

### 3. Set Your Development Team
TARGET → Signing & Capabilities → Team

### 4. Update the Bundle Identifier
Change `com.example.MyApp` to a unique identifier.

---

## 🛠️ Notes
- Notes are saved as `notes.json` in the app's sandboxed documents directory.
- If you see a code signing error, check that Team and Bundle ID are set.

## 📦 Requirements
- Xcode 16+
- macOS 13+

📺 [Watch the guide on YouTube](https://youtu.be/sSAPsakD5l0)
