# Business Quiz App 🎯

A modern, interactive Flutter quiz application designed to test business knowledge with a sleek UI, smooth animations, and engaging user experience.

## 👥 Group Name
**Para CodeCode**

## 🎭 Members + Roles

| Name | Role | Responsibilities |
|------|------|-----------------|
| Shenna A. Salcedo | UI/UX Designer / Project Lead | Interface design, animations, user experience optimization |
| Vincent S. Perez | Backend Developer / Tester | Quiz logic implementation, timer functionality, testing |
| Nico John C. San Lorenzo | Documentation / Frontend Developer | README documentation, code review, bug testing |

---

## 🚀 Project Setup

### Prerequisites
Before you begin, ensure you have the following installed on your system:

- **Flutter SDK** (3.0 or higher) - [Download here](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (2.17 or higher) - Comes with Flutter
- **Git** - [Download here](https://git-scm.com/downloads)
- **Code Editor:**
  - [Visual Studio Code](https://code.visualstudio.com/) with Flutter extension, OR
  - [Android Studio](https://developer.android.com/studio) with Flutter plugin
- **Optional:** Android Emulator or iOS Simulator for testing

### Installation Steps

#### 1. **Clone the Repository**
```bash
git clone https://github.com/Shen-is-pretty/bsis3A-Para-CodeCode.git
cd bsis3A-Para-CodeCode
```

#### 2. **Verify Flutter Installation**
```bash
flutter doctor
```
This command checks your Flutter installation and shows any dependencies you need to install.

#### 3. **Install Dependencies**
```bash
flutter pub get
```

#### 4. **Run the Application**

**For Android:**
```bash
flutter run -d android
```

**For iOS (macOS only):**
```bash
flutter run -d ios
```

**For Web:**
```bash
flutter run -d chrome
```

**For Desktop:**
```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

**To see available devices:**
```bash
flutter devices
```

---

## 📁 Project Structure

```
flutter_njvs/
├── lib/
│   └── main.dart                 # Main application code
├── android/                      # Android-specific files
├── ios/                          # iOS-specific files
├── web/                          # Web-specific files
├── windows/                      # Windows-specific files
├── linux/                        # Linux-specific files
├── macos/                        # macOS-specific files
├── test/                         # Test files
├── pubspec.yaml                  # Project dependencies
├── .gitignore                    # Git ignore rules
└── README.md                     # This file
```

---

## ✨ Features

### 🎨 User Interface
- **Modern Material Design 3** - Clean, professional interface
- **Smooth Animations** - Fade transitions between screens
- **Responsive Layout** - Works seamlessly on mobile, tablet, and desktop
- **Color-Coded Feedback** - Green for correct, red for incorrect answers

### ⏱️ Quiz Functionality
- **5 Business Questions** - Covers automation, AI, cloud services, RPA, and SWOT analysis
- **60-Second Timer** - Challenge yourself to complete the quiz quickly
- **Real-Time Feedback** - Instant visual feedback on answer selection
- **Progress Tracking** - Visual progress bar and question counter
- **Score Calculation** - Automatic scoring with percentage display

### 🎯 User Experience
- **Easy Navigation** - Clear flow from start to quiz to results
- **Retake Option** - Restart quiz anytime to improve your score
- **Passing Threshold** - 70% required to pass
- **Visual Indicators** - Icons and colors guide user through experience

---

## 📚 Quiz Topics Covered

1. **Business Automation** - Why businesses use automation
2. **AI Innovation** - Examples of AI in business applications
3. **Cloud Services** - Purpose of cloud integration
4. **RPA (Robotic Process Automation)** - Understanding automation terminology
5. **SWOT Analysis** - Strategic business analysis methods

---

## 🎮 How to Use

1. **Launch the App** - Open the application on your device
2. **Review Quiz Info** - See question count, time limit, and passing score
3. **Start Quiz** - Click the "Start Quiz" button
4. **Answer Questions** - Select your answer for each question (A, B, C, or D)
5. **Navigate** - Click "Next Question" after selecting an answer
6. **View Results** - See your final score and percentage
7. **Retake** - Click "Retake Quiz" to try again

---

## 🛠️ Technical Details

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Material Design 3 is built into Flutter
```

### Key Technologies

- **Flutter Framework** - UI toolkit for building natively compiled applications
- **Dart Language** - Programming language optimized for UI
- **Material Design 3** - Google's latest design system
- **StatefulWidget** - For managing quiz state and interactions

### Code Architecture

#### Main Components

1. **MyApp** - Root application widget with theme configuration
2. **QuizScreen** - Main quiz interface (StatefulWidget)
3. **Question** - Data model for quiz questions
4. **_QuizScreenState** - Manages quiz state, timer, and animations

#### State Management
- Uses built-in Flutter state management with `setState()`
- Timer managed with `dart:async` Timer class
- Animations controlled with `AnimationController`

#### UI Screens
1. **Start View** - Welcome screen with quiz information
2. **Quiz View** - Active quiz with questions and timer
3. **End View** - Results screen with score and retake option

---

## 🎨 Customization Guide

### Adding New Questions

Add more questions to the `questions` list in `main.dart`:

```dart
Question(
  questionText: 'Your question here?',
  answers: [
    'Option A',
    'Option B',
    'Option C',
    'Option D',
  ],
  correctAnswerIndex: 0, // Index of correct answer (0-3)
),
```

### Changing Timer Duration

Modify the initial timer value in `_QuizScreenState`:

```dart
int _secondsRemaining = 60; // Change to your desired seconds
```

### Updating Theme Colors

Edit the color scheme in `MyApp` widget:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFF2563EB), // Change this color
  brightness: Brightness.light,
),
```

### Adjusting Passing Score

Modify the passing percentage in `buildEndView()`:

```dart
final isPassing = percentage >= 70; // Change 70 to your threshold
```

---

## 🐛 Troubleshooting

### Common Issues

**Issue:** `flutter: command not found`
- **Solution:** Ensure Flutter is added to your PATH. Run `flutter doctor` to verify installation.

**Issue:** `pub get failed`
- **Solution:** Check your internet connection and run `flutter pub get` again.

**Issue:** `No devices found`
- **Solution:** 
  - For Android: Start an emulator or connect a physical device
  - For iOS: Open Simulator (macOS only)
  - For Web: Ensure Chrome is installed

**Issue:** Git line ending warnings (LF/CRLF)
- **Solution:** This is normal on Windows. Add a `.gitattributes` file:
  ```
  * text=auto
  *.dart text eol=lf
  ```

---

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Supported | API 21+ |
| iOS | ✅ Supported | iOS 11+ |
| Web | ✅ Supported | Modern browsers |
| Windows | ✅ Supported | Windows 10+ |
| macOS | ✅ Supported | macOS 10.14+ |
| Linux | ✅ Supported | 64-bit |

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork the Repository**
2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit Your Changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the Branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Code Style Guidelines
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Test your changes before submitting

---

## 📄 License
This project is created for educational purposes as part of our coursework.

---

## 📞 Contact & Support
**Team:** Para CodeCode  
**Repository:** [bsis3A-Para-CodeCode](https://github.com/Shen-is-pretty/bsis3A-Para-CodeCode)

For questions, issues, or suggestions:
- Open an issue on GitHub
- Contact any team member
- Submit a pull request

---

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Material Design Team for design guidelines
- Our instructor for project guidance
- All team members for their contributions

---

## 📊 Project Stats
- **Language:** Dart
- **Framework:** Flutter
- **Questions:** 5
- **Time Limit:** 60 seconds
- **Passing Score:** 70%
- **Platforms:** Android, iOS, Web, Desktop
