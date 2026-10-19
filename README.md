# Flutter QR Code App

A simple yet professional Flutter application for **generating** and **scanning** QR codes. This project is perfect for beginners looking to learn about basic navigation, the use of third-party packages, and state management in Flutter.

---

## Key Features

1. **Generate QR Code**: Instantly convert user-input text or URLs into a QR code image.
2. **Scan QR Code**: Scan QR codes directly using the device's camera.
3. **Smart URL Redirection**: If the scanned result is a link/URL (http/https), the app displays a dedicated button to open it directly in an external browser.
4. **Bottom Navigation**: A clean bottom navigation bar to switch between the *Generate* and *Scan* pages.

---

## Packages / Dependencies Used

This application utilizes several external packages from [pub.dev](https://pub.dev/):

* [`qr_flutter`](https://pub.dev/packages/qr_flutter) – For rendering and displaying QR codes.
* [`mobile_scanner`](https://pub.dev/packages/mobile_scanner) – For real-time QR code scanning using the camera.
* [`url_launcher`](https://pub.dev/packages/url_launcher) – For opening URLs in an external browser.

---

## Project Structure

```text
lib/
│
├── main.dart      # Application entry point & Bottom Navigation
├── generate_qr_code.dart     # Page for entering text/URL to generate a QR code
├── qr_image.dart             # Page for displaying the generated QR code
└── scan_qr_code.dart         # Page for camera scanning & URL handling
```

## How to Run the Project

Follow the steps below to run the application on your device or emulator:

1. Clone or open the project in your preferred editor (such as VS Code or Android Studio). 

2. Open your terminal and run the following command to download all required packages:
```bash
flutter pub get
```

3. Ensure that a device (an emulator or a physical phone with USB Debugging enabled) is connected.

4. Run the application using the following command:
```bash
flutter run
```