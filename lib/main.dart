import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme.dart';
import 'routes/route.dart';
import 'view/screens/splash_screen.dart';
import 'data/controller/cart_controller.dart';
import 'data/controller/map_controller.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // print('Warning: Could not load .env file');
  }
  Get.put(CartController()); // Initialize CartController globally
  Get.put(MapController(), permanent: true); // Initialize MapController globally
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:
          (context, child) => GetMaterialApp(
            title: 'Blinkit',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English
              Locale('hi', ''), // Hindi
            ],
            home: const SplashScreen(),
            getPages: Routes.pages,
          ),
    );
  }
}
