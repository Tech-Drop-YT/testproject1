import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/calculator_controller.dart';
import '../widgets/button.dart';
import '../widgets/display.dart';
import '../../history/ui/history_screen.dart';
import '../../settings/ui/settings_screen.dart';

class ScientificCalculator extends StatelessWidget {
  const ScientificCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalculatorController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solvex - Scientific'),
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

              const SizedBox(height: 16),

              // Mode Toggle and Angle Unit
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: controller.toggleMode,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Standard'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      controller.isRadians ? 'RAD' : 'DEG',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.toggleAngleUnit,
                    child: const Text('Toggle RAD/DEG'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Memory Indicator
              if (controller.hasMemory)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'M: ${controller.memory}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 16),

              // Calculator Buttons
              Expanded(
                child: SingleChildScrollView(
                  child: _buildButtonGrid(context, controller),
                ),
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
        // Row 1: Memory operations
        _buildRow(context, controller, [
          ('MC', ButtonType.function),
          ('MR', ButtonType.function),
          ('M+', ButtonType.function),
          ('M-', ButtonType.function),
        ]),
        const SizedBox(height: 8),

        // Row 2: Functions
        _buildRow(context, controller, [
          ('sin', ButtonType.function),
          ('cos', ButtonType.function),
          ('tan', ButtonType.function),
          ('π', ButtonType.special),
        ]),
        const SizedBox(height: 8),

        // Row 3: Inverse Functions
        _buildRow(context, controller, [
          ('asin', ButtonType.function),
          ('acos', ButtonType.function),
          ('atan', ButtonType.function),
          ('e', ButtonType.special),
        ]),
        const SizedBox(height: 8),

        // Row 4: Log and Root
        _buildRow(context, controller, [
          ('ln', ButtonType.function),
          ('log', ButtonType.function),
          ('√', ButtonType.function),
          ('∛', ButtonType.function),
        ]),
        const SizedBox(height: 8),

        // Row 5: Powers and Parenthesis
        _buildRow(context, controller, [
          ('x²', ButtonType.function),
          ('x³', ButtonType.function),
          ('^', ButtonType.operator),
          ('(', ButtonType.special),
        ]),
        const SizedBox(height: 8),

        // Row 6: C, ⌫, %, )
        _buildRow(context, controller, [
          ('C', ButtonType.clear),
          ('⌫', ButtonType.special),
          ('%', ButtonType.special),
          (')', ButtonType.special),
        ]),
        const SizedBox(height: 8),

        // Row 7: 7, 8, 9, ÷
        _buildRow(context, controller, [
          ('7', ButtonType.number),
          ('8', ButtonType.number),
          ('9', ButtonType.number),
          ('÷', ButtonType.operator),
        ]),
        const SizedBox(height: 8),

        // Row 8: 4, 5, 6, ×
        _buildRow(context, controller, [
          ('4', ButtonType.number),
          ('5', ButtonType.number),
          ('6', ButtonType.number),
          ('×', ButtonType.operator),
        ]),
        const SizedBox(height: 8),

        // Row 9: 1, 2, 3, -
        _buildRow(context, controller, [
          ('1', ButtonType.number),
          ('2', ButtonType.number),
          ('3', ButtonType.number),
          ('-', ButtonType.operator),
        ]),
        const SizedBox(height: 8),

        // Row 10: +/-, 0, ., +
        _buildRow(context, controller, [
          ('+/-', ButtonType.special),
          ('0', ButtonType.number),
          ('.', ButtonType.number),
          ('+', ButtonType.operator),
        ]),
        const SizedBox(height: 8),

        // Row 11: Equal button (full width)
        SizedBox(
          height: 60,
          child: CalculatorButton(
            text: '=',
            type: ButtonType.equal,
            onPressed: () => controller.onButtonPressed('='),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
    BuildContext context,
    CalculatorController controller,
    List<(String, ButtonType)> buttons,
  ) {
    return SizedBox(
      height: 60,
      child: Row(
        children: buttons.map((button) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CalculatorButton(
                text: button.$1,
                type: button.$2,
                isSmall: button.$1.length > 3,
                onPressed: () => controller.onButtonPressed(button.$1),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
