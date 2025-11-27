// FILE: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'src/controllers/game_controller.dart';
import 'src/controllers/theme_controller.dart';
import 'src/services/audio_service.dart';
import 'src/ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services
  await _initServices();

  runApp(const LudoApp());
}

/// Initialize GetX services
Future<void> _initServices() async {
  // Audio service
  await Get.putAsync(() => AudioService().init());

  // Theme controller
  Get.put(ThemeController());

  // Game controller
  Get.put(GameController());
}

class LudoApp extends StatelessWidget {
  const LudoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Ludo Dual Dice',
        debugShowCheckedModeBanner: false,
        theme: ThemeController.lightTheme,
        darkTheme: ThemeController.darkTheme,
        themeMode: themeController.themeMode,
        home: const HomeScreen(),
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
