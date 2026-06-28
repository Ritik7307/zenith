# Zenith ⛰️

Zenith is a premium, locally-first productivity and student companion app built with Flutter. It's designed to help you build consistency, track your college attendance, manage your timetable, and enter deep focus states—all completely offline and private to your device.

## Features ✨

### 🎓 College Companion
* **Attendance Tracker**: Add subjects with specific target percentages (e.g., 75%). Log present and absent days date-wise. The app automatically calculates your current percentage and tells you exactly how many classes you can afford to miss (or need to attend) to stay safe.
* **Timetable Manager**: A 7-day horizontal scrollable timetable. Add classes with start times, end times, subject names, and location/room numbers. Classes are automatically sorted chronologically so you never fumble looking for your next room.

### 📈 Consistency & Analytics
* **Habit Tracking**: Build unbreakable consistency by tracking daily habits.
* **Profile & Progress Heap**: Your dedicated profile hub features a 30-day "Progress Heap" (Activity Heatmap) that visually maps out your consistency over the last month.
* **Analytics Dashboard**: View your total score, habits completed today, overall completion percentage, total focus time, and your longest streak.

### ⏱️ Deep Work
* **Focus Timer**: A built-in timer designed to help you get into flow states and track your focused hours.

### 🎯 Goal Setting
* **Goals Module**: Define and track your long-term and short-term goals.

## Tech Stack 🛠️

* **Framework**: [Flutter](https://flutter.dev/)
* **Local Database**: [Isar](https://isar.dev/) (Blazing fast, NoSQL local database)
* **State Management**: [Riverpod](https://riverpod.dev/) (Safe, reactive state management)
* **Routing**: [GoRouter](https://pub.dev/packages/go_router) (Declarative routing)
* **UI/UX Aesthetics**: Custom sleek monochromatic grey theme with carefully curated typography (Google Fonts - Inter).

## Getting Started 🚀

### Prerequisites
* Flutter SDK (Latest stable version)
* Android Studio / VS Code with Flutter extensions installed

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/zenith.git
   ```
2. Navigate to the project directory:
   ```bash
   cd zenith
   ```
3. Get the dependencies:
   ```bash
   flutter pub get
   ```
4. Generate the Isar database schemas and Riverpod files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## Privacy First 🔒
Zenith does not require an internet connection or any cloud accounts. **100% of your data** (attendance, timetable, habits, identity) is stored entirely in the local storage of your device using the Isar database engine. Your data is yours.

---
*Built to help you reach your peak.*
