import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/local_storage.dart';
import '../../../core/constants/colors.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  final LocalStorageService _storageService = LocalStorageService();

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _isDarkMode = await _storageService.getThemeMode();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _storageService.saveThemeMode(_isDarkMode);
    notifyListeners();
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalStorageService _storageService = LocalStorageService();
  bool _vibrationEnabled = true;
  bool _soundEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final vibration = await _storageService.getVibrationEnabled();
    final sound = await _storageService.getSoundEnabled();

    setState(() {
      _vibrationEnabled = vibration;
      _soundEnabled = sound;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Section
          _buildSectionTitle(context, 'Appearance'),
          const SizedBox(height: 12),
          _buildSettingCard(
            context,
            icon: isDark ? Icons.dark_mode : Icons.light_mode,
            title: 'Dark Mode',
            subtitle: isDark ? 'Enabled' : 'Disabled',
            trailing: Switch(
              value: isDark,
              onChanged: (value) => themeProvider.toggleTheme(),
              activeColor: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(height: 24),

          // Feedback Section
          _buildSectionTitle(context, 'Feedback'),
          const SizedBox(height: 12),
          _buildSettingCard(
            context,
            icon: Icons.vibration,
            title: 'Vibration',
            subtitle: 'Haptic feedback on button press',
            trailing: Switch(
              value: _vibrationEnabled,
              onChanged: (value) {
                setState(() => _vibrationEnabled = value);
                _storageService.saveVibrationEnabled(value);
              },
              activeColor: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(height: 12),

          _buildSettingCard(
            context,
            icon: Icons.volume_up,
            title: 'Sound',
            subtitle: 'Sound effects on button press',
            trailing: Switch(
              value: _soundEnabled,
              onChanged: (value) {
                setState(() => _soundEnabled = value);
                _storageService.saveSoundEnabled(value);
              },
              activeColor: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(height: 24),

          // About Section
          _buildSectionTitle(context, 'About'),
          const SizedBox(height: 12),
          _buildSettingCard(
            context,
            icon: Icons.info_outline,
            title: 'Version',
            subtitle: '1.0.0',
          ),

          const SizedBox(height: 12),

          _buildSettingCard(
            context,
            icon: Icons.code,
            title: 'Solvex',
            subtitle: 'Modern Calculator App',
          ),

          const SizedBox(height: 24),

          // Branding
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.calculate_rounded,
                  size: 64,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(height: 12),
                Text(
                  'Solvex',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Calculate with confidence',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primaryBlue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: trailing,
      ),
    );
  }
}
