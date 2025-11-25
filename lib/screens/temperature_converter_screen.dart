import 'package:flutter/material.dart';
import 'package:solvex/utils/temperature_converter.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  final List<String> units = ['Celsius', 'Fahrenheit', 'Kelvin', 'Rankine', 'Reaumur'];
  final Map<String, TextEditingController> controllers = {};
  final Map<String, FocusNode> focusNodes = {};
  String activeUnit = 'Celsius';

  @override
  void initState() {
    super.initState();
    for (var unit in units) {
      controllers[unit] = TextEditingController(text: '0');
      focusNodes[unit] = FocusNode();
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    for (var focusNode in focusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _convertTemperature(String sourceUnit, String value) {
    if (value.isEmpty) {
      for (var unit in units) {
        if (unit != sourceUnit) {
          controllers[unit]!.text = '';
        }
      }
      return;
    }

    try {
      final sourceValue = double.parse(value);
      setState(() {
        activeUnit = sourceUnit;
        for (var unit in units) {
          if (unit != sourceUnit) {
            final converted = TemperatureConverter.convert(sourceValue, sourceUnit, unit);
            controllers[unit]!.text = converted.toStringAsFixed(2);
          }
        }
      });
    } catch (e) {
      // Invalid number
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = const Color(0xFFFF6D00);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Convert Temperature',
                style: theme.textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter a value in any unit to convert',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              ...units.map((unit) => _buildUnitCard(
                    unit: unit,
                    symbol: TemperatureConverter.getSymbol(unit),
                    color: primaryColor,
                    theme: theme,
                  )),
              const SizedBox(height: 24),
              _buildInfoCard(theme, primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitCard({
    required String unit,
    required String symbol,
    required Color color,
    required ThemeData theme,
  }) {
    final isActive = activeUnit == unit;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: isActive ? 4 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isActive
              ? BorderSide(color: color, width: 2)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        symbol,
                        style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unit,
                          style: theme.textTheme.titleLarge,
                        ),
                        Text(
                          symbol,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controllers[unit],
                focusNode: focusNodes[unit],
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: theme.textTheme.headlineMedium,
                decoration: InputDecoration(
                  hintText: '0',
                  suffixText: symbol,
                  suffixStyle: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: (value) => _convertTemperature(unit, value),
                onTap: () {
                  setState(() {
                    activeUnit = unit;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline_rounded, color: color),
                const SizedBox(width: 12),
                Text(
                  'About Temperature Scales',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Celsius', 'Water freezes at 0°C, boils at 100°C', theme),
            _buildInfoRow('Fahrenheit', 'Water freezes at 32°F, boils at 212°F', theme),
            _buildInfoRow('Kelvin', 'Absolute zero at 0K, water freezes at 273.15K', theme),
            _buildInfoRow('Rankine', 'Absolute zero at 0R, water freezes at 491.67R', theme),
            _buildInfoRow('Reaumur', 'Water freezes at 0°Re, boils at 80°Re', theme),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String description, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFFF6D00),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
