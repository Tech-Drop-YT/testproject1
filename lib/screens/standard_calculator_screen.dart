import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solvex/providers/calculator_provider.dart';
import 'package:solvex/widgets/calculator_button.dart';
import 'package:solvex/screens/history_screen.dart';

class StandardCalculatorScreen extends StatelessWidget {
  const StandardCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: const _StandardCalculatorContent(),
    );
  }
}

class _StandardCalculatorContent extends StatelessWidget {
  const _StandardCalculatorContent();

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<CalculatorProvider>(context);
    final theme = Theme.of(context);
    final primaryColor = const Color(0xFF2962FF);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: calculator,
                    child: const HistoryScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (calculator.expression.isNotEmpty)
                      Text(
                        calculator.expression,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    const SizedBox(height: 8),
                    Text(
                      calculator.display,
                      style: theme.textTheme.displayLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // Buttons
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Row 1: C, ±, %, ÷
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalculatorButton(
                              text: 'C',
                              onPressed: calculator.clear,
                              backgroundColor: primaryColor.withOpacity(0.2),
                              textColor: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '±',
                              onPressed: calculator.toggleSign,
                              backgroundColor: primaryColor.withOpacity(0.1),
                              textColor: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '%',
                              onPressed: calculator.percentage,
                              backgroundColor: primaryColor.withOpacity(0.1),
                              textColor: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '÷',
                              onPressed: () => calculator.appendOperator('÷'),
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 2: 7, 8, 9, ×
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalculatorButton(
                              text: '7',
                              onPressed: () => calculator.appendNumber('7'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '8',
                              onPressed: () => calculator.appendNumber('8'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '9',
                              onPressed: () => calculator.appendNumber('9'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '×',
                              onPressed: () => calculator.appendOperator('×'),
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 3: 4, 5, 6, -
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalculatorButton(
                              text: '4',
                              onPressed: () => calculator.appendNumber('4'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '5',
                              onPressed: () => calculator.appendNumber('5'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '6',
                              onPressed: () => calculator.appendNumber('6'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '-',
                              onPressed: () => calculator.appendOperator('-'),
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 4: 1, 2, 3, +
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalculatorButton(
                              text: '1',
                              onPressed: () => calculator.appendNumber('1'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '2',
                              onPressed: () => calculator.appendNumber('2'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '3',
                              onPressed: () => calculator.appendNumber('3'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '+',
                              onPressed: () => calculator.appendOperator('+'),
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 5: 0, ., ⌫, =
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalculatorButton(
                              text: '0',
                              onPressed: () => calculator.appendNumber('0'),
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '.',
                              onPressed: calculator.appendDecimal,
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '⌫',
                              onPressed: calculator.backspace,
                              backgroundColor: primaryColor.withOpacity(0.1),
                              textColor: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: CalculatorButton(
                              text: '=',
                              onPressed: calculator.calculate,
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
