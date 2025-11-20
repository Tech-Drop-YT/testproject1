import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/calculator_controller.dart';
import '../widgets/button.dart';
import '../widgets/display.dart';
import '../../history/ui/history_screen.dart';
import '../../settings/ui/settings_screen.dart';

class StandardCalculator extends StatelessWidget {
  const StandardCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalculatorController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solvex'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
            tooltip: 'History',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display
              CalculatorDisplay(
                expression: controller.expression,
                result: controller.display,
              ),

              const SizedBox(height: 24),

              // Mode Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: controller.toggleMode,
                    icon: const Icon(Icons.functions),
                    label: const Text('Scientific Mode'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Calculator Buttons
              Expanded(
                child: _buildButtonGrid(context, controller),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonGrid(BuildContext context, CalculatorController controller) {
    return Column(
      children: [
        // Row 1: C, ⌫, %, ÷
        Expanded(
          child: Row(
            children: [
              _buildButton(context, controller, 'C', ButtonType.clear),
              _buildButton(context, controller, '⌫', ButtonType.special),
              _buildButton(context, controller, '%', ButtonType.special),
              _buildButton(context, controller, '÷', ButtonType.operator),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Row 2: 7, 8, 9, ×
        Expanded(
          child: Row(
            children: [
              _buildButton(context, controller, '7', ButtonType.number),
              _buildButton(context, controller, '8', ButtonType.number),
              _buildButton(context, controller, '9', ButtonType.number),
              _buildButton(context, controller, '×', ButtonType.operator),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Row 3: 4, 5, 6, -
        Expanded(
          child: Row(
            children: [
              _buildButton(context, controller, '4', ButtonType.number),
              _buildButton(context, controller, '5', ButtonType.number),
              _buildButton(context, controller, '6', ButtonType.number),
              _buildButton(context, controller, '-', ButtonType.operator),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Row 4: 1, 2, 3, +
        Expanded(
          child: Row(
            children: [
              _buildButton(context, controller, '1', ButtonType.number),
              _buildButton(context, controller, '2', ButtonType.number),
              _buildButton(context, controller, '3', ButtonType.number),
              _buildButton(context, controller, '+', ButtonType.operator),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Row 5: +/-, 0, ., =
        Expanded(
          child: Row(
            children: [
              _buildButton(context, controller, '+/-', ButtonType.special),
              _buildButton(context, controller, '0', ButtonType.number),
              _buildButton(context, controller, '.', ButtonType.number),
              _buildButton(context, controller, '=', ButtonType.equal),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    CalculatorController controller,
    String text,
    ButtonType type,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CalculatorButton(
          text: text,
          type: type,
          onPressed: () => controller.onButtonPressed(text),
        ),
      ),
    );
  }
}
