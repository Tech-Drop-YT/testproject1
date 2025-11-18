import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/story_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/cart_provider.dart';
import 'services/storage_service.dart';
import 'services/story_service.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services
  final storageService = StorageService();
  await storageService.init();

  final storyService = StoryService();

  runApp(
    MultiProvider(
      providers: [
        // Services
        Provider<StorageService>.value(value: storageService),
        Provider<StoryService>.value(value: storyService),

        // Providers
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => StoryProvider(storyService),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(storageService),
        ),
      ],
      child: const DreamyTalesApp(),
    ),
  );
}

class DreamyTalesApp extends StatelessWidget {
  const DreamyTalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'DreamyTales',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
