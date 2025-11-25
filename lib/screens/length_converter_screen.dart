import 'package:flutter/material.dart';
import 'package:solvex/utils/length_converter.dart';

class LengthConverterScreen extends StatefulWidget {
  const LengthConverterScreen({super.key});

  @override
  State<LengthConverterScreen> createState() => _LengthConverterScreenState();
}

class _LengthConverterScreenState extends State<LengthConverterScreen> {
  final List<String> units = [
    'Meter',
    'Centimeter',
    'Millimeter',
    'Kilometer',
    'Inch',
    'Foot',
    'Yard',
    'Mile',
    'Nautical Mile',
  ];

  final Map<String, TextEditingController> controllers = {};
  final Map<String, FocusNode> focusNodes = {};
  String activeUnit = 'Meter';

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

  void _convertLength(String sourceUnit, String value) {
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
            final converted = LengthConverter.convert(sourceValue, sourceUnit, unit);
            // Use appropriate precision based on magnitude
            if (converted.abs() < 0.01) {
              controllers[unit]!.text = converted.toStringAsExponential(4);
            } else if (converted.abs() > 1000000) {
              controllers[unit]!.text = converted.toStringAsExponential(4);
            } else {
              controllers[unit]!.text = converted.toStringAsFixed(6).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
            }
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
    final primaryColor = const Color(0xFF00BFA5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Length Converter'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Convert Length',
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter a value in any unit to convert',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: units.length,
                itemBuilder: (context, index) {
                  final unit = units[index];
                  return _buildUnitCard(
                    unit: unit,
                    symbol: LengthConverter.getSymbol(unit),
                    description: LengthConverter.getDescription(unit),
                    color: primaryColor,
                    theme: theme,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitCard({
    required String unit,
    required String symbol,
    required String description,
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
                          fontSize: 16,
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
                          description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                          ),
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
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: 22),
                decoration: InputDecoration(
                  hintText: '0',
                  suffixText: symbol,
                  suffixStyle: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: (value) => _convertLength(unit, value),
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
}
