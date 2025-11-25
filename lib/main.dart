import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solvex/providers/theme_provider.dart';
import 'package:solvex/theme/app_theme.dart';
import 'package:solvex/screens/home_screen.dart';

void main() {
  runApp(const SolvexApp());
}

class SolvexApp extends StatelessWidget {
  const SolvexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Solvex',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
