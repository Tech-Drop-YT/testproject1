import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solvex/providers/theme_provider.dart';
import 'package:solvex/screens/standard_calculator_screen.dart';
import 'package:solvex/screens/scientific_calculator_screen.dart';
import 'package:solvex/screens/temperature_converter_screen.dart';
import 'package:solvex/screens/length_converter_screen.dart';
import 'package:solvex/screens/bmi_calculator_screen.dart';
import 'package:solvex/widgets/calculator_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final calculators = [
      CalculatorItem(
        title: 'Standard Calculator',
        subtitle: 'Basic arithmetic operations',
        icon: Icons.calculate_rounded,
        color: const Color(0xFF2962FF),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StandardCalculatorScreen()),
        ),
      ),
      CalculatorItem(
        title: 'Scientific Calculator',
        subtitle: 'Advanced mathematical functions',
        icon: Icons.functions_rounded,
        color: const Color(0xFF7C4DFF),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ScientificCalculatorScreen()),
        ),
      ),
      CalculatorItem(
        title: 'Temperature Converter',
        subtitle: 'Convert between temperature units',
        icon: Icons.thermostat_rounded,
        color: const Color(0xFFFF6D00),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TemperatureConverterScreen()),
        ),
      ),
      CalculatorItem(
        title: 'Length Converter',
        subtitle: 'Convert between distance units',
        icon: Icons.straighten_rounded,
        color: const Color(0xFF00BFA5),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LengthConverterScreen()),
        ),
      ),
      CalculatorItem(
        title: 'BMI Calculator',
        subtitle: 'Calculate Body Mass Index',
        icon: Icons.monitor_weight_rounded,
        color: const Color(0xFFD81B60),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BMICalculatorScreen()),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solvex'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a Calculator',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Select from our professional tools',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: calculators.length,
                  itemBuilder: (context, index) {
                    return CalculatorCard(
                      item: calculators[index],
                      delay: index * 100,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  CalculatorItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
