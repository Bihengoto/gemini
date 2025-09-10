# Dart SDK and IDE Installation Guide

## Installing Dart SDK

### Windows
1. Download Dart SDK from https://dart.dev/get-dart
2. Extract the zip file to a folder (e.g., C:\dart-sdk)
3. Add the `bin` directory to your PATH environment variable
4. Verify installation: `dart --version`

### macOS
```bash
# Using Homebrew
brew tap dart-lang/dart
brew install dart

# Or download from dart.dev
```

### Linux
```bash
# Using apt (Ubuntu/Debian)
sudo apt update
sudo apt install apt-transport-https
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo apt update
sudo apt install dart
```

## Setting up Visual Studio Code

### 1. Install VS Code
- Download from https://code.visualstudio.com/
- Install the application

### 2. Install Dart Extension
- Open VS Code
- Go to Extensions (Ctrl+Shift+X)
- Search for "Dart"
- Install the official Dart extension by Dart Code

### 3. Verify Setup
- Create a new .dart file
- VS Code should recognize Dart syntax
- You should see Dart commands in the command palette (Ctrl+Shift+P)

## Alternative IDEs
- **Android Studio**: With Dart plugin
- **IntelliJ IDEA**: With Dart plugin
- **Vim/Neovim**: With Dart language server
- **Emacs**: With dart-mode

## Verification
Run these commands to verify your setup:
```bash
dart --version
dart create hello_world
cd hello_world
dart run
```