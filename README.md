# 🎵 Flutter Music Player with XAMPP Backend

![Flutter](https://img.shields.io/badge/Flutter-3.19-blue?logo=flutter)
![PHP](https://img.shields.io/badge/PHP-8.0+-purple?logo=php)
![MySQL](https://img.shields.io/badge/MySQL-5.7+-blue?logo=mysql)

A simple music player app built with Flutter, using XAMPP for backend API and database management.

![App Screenshot](screenshots/2.png)
![Login Screen](screenshots/1.png)


## ✨ Features
- 🎶 Play local/streamed audio files
- 📱 Cross-platform (Android, Web, Desktop)
- 🔍 Browse songs by artist/album
- 💾 XAMPP backend for user authentication

## 🛠️ Tech Stack
| Component       | Technology           |
|----------------|---------------------|
| Frontend       | Flutter (Dart)      |
| Backend        | XAMPP (Apache/PHP)  |
| Database       | MySQL               |
| API            | RESTful PHP API     |

## 🚀 Setup Guide

### Backend (XAMPP)
1. Install [XAMPP](https://www.apachefriends.org/download.html)
2. Clone this repo's `backend/` folder to `htdocs/`
3. Import `database/music_player.sql` to phpMyAdmin

### Frontend (Flutter)
```bash
git clone https://github.com/zaephyrz/flutter-music-player.git
cd flutter-music-player
flutter pub get
flutter run
