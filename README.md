# 📰 NewsPulse

NewsPulse is a SwiftUI-based iOS application that fetches and displays the latest news headlines using a public news API.  
It’s built using **Swift**, **Combine**, and **async/await** for modern, efficient networking.

---

## 🚀 Features

- Fetches top headlines from the News API
- Displays news articles with title, description, and image
- Clean, minimal SwiftUI user interface
- Uses `async/await` for network calls
- MVVM architecture for better code separation

---

## 🧠 Tech Stack

| Layer | Technologies Used |
|-------|--------------------|
| UI | SwiftUI |
| Networking | URLSession with async/await |
| Architecture | MVVM |
| API | NewsAPI.org (or your configured news API) |

---


## Getting started

```bash
git clone https://github.com/sachinarkasali944/NewsPulse.git
cd NewsPulse
open "NewsPulse/NewsPulse.xcodeproj"
```

Select the app scheme and a simulator matching the deployment target in Xcode, then press **⌘R**. For device deployment, select your development team. Use an Xcode version with SDK support for the committed project.

### API configuration

The app calls NewsAPI. Configure your own API key locally in `NewsPulse/NewsPulse/Services/NewsAPIService.swift`. Keep credentials out of commits; the README does not reproduce any embedded key.
