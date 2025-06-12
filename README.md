# Blinkit Clone (Flutter)

A feature-rich UI clone of the Blinkit grocery delivery app, built with Flutter and GetX. This project aims to replicate the core user interface and user experience of Blinkit, showcasing a modern, responsive design, smooth animations, and a clean architecture.

## 📸 Screenshots

*(Add screenshots and GIFs of the app here to showcase the UI)*

| Splash Screen | Login Screen | Home Screen |
| :---: |:---:|:---:|
| *(Image)* | *(Image)* | *(Image)* |

| Categories | Cart | Address Picker |
| :---: |:---:|:---:|
| *(Image)* | *(Image)* | *(Image)* |

## ✨ Features

- **User Authentication**: Phone number based login with OTP verification.
- **Dynamic Home Screen**: Displaying various categories and product carousels.
- **Product Discovery**: Browse products by category with a dedicated categories screen.
- **Shopping Cart**: Add, remove, and manage items in the cart.
- **Address Selection**: Integrated Google Maps to pick a delivery address.
- **Mock Checkout Flow**: Simulated payment process with Razorpay integration.
- **Order Status**: Post-payment success screen and an order details view.
- **Permissions Handling**: Gracefully requests necessary permissions like location.
- **Responsive UI**: Adapts to different screen sizes using `flutter_screenutil`.

## 📚 Tech Stack & Libraries

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **Architecture**: Clean architecture principles with GetX.
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Routing**: GetX
- **UI Packages**:
  - `flutter_screenutil`: For responsive UI.
  - `google_fonts`: For custom fonts.
  - `pin_code_fields`: For OTP input fields.
  - `lottie`: For high-quality animations (e.g., payment success).
- **Services & Integrations**:
  - `google_maps_flutter`: For map-based address selection.
  - `razorpay_flutter`: For payment gateway integration.
- **Utilities**:
  - `permission_handler`: To manage device permissions.

## 🗃️ Project Structure

The project follows a feature-first directory structure to maintain scalability and organization.

```
lib/
├── api/                 # API service classes
├── bindings/            # GetX initial bindings
├── core/                # Core utilities (colors, fonts, etc.)
├── data/
│   ├── model/           # Data models
│   └── static_data/     # Mock/static data
├── routes/              # App route definitions
├── view/
│   ├── components/      # Reusable widgets
│   └── screens/         # UI screens
├── main.dart            # App entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.x.x)
- Dart SDK (version 3.x.x)
- An editor like VS Code or Android Studio.

### Installation

1.  **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/flutter-blinkit-clone.git
    cd flutter-blinkit-clone
    ```

2.  **Install dependencies**:
    ```sh
    flutter pub get
    ```

3.  **Configure API Keys**:
    - You will need to provide your own API key for Google Maps.
    - Add it to the `android/app/src/main/AndroidManifest.xml`:
      ```xml
      <meta-data android:name="com.google.android.geo.API_KEY"
                 android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
      ```
    - For iOS, add it to `ios/Runner/AppDelegate.swift`.

4.  **Run the app**:
    ```sh
    flutter run
    ```

---
