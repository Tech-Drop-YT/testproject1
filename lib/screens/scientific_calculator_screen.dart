import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solvex/providers/scientific_calculator_provider.dart';
import 'package:solvex/widgets/calculator_button.dart';

class ScientificCalculatorScreen extends StatelessWidget {
  const ScientificCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScientificCalculatorProvider(),
      child: const _ScientificCalculatorContent(),
    );
  }
}

class _ScientificCalculatorContent extends StatelessWidget {
  const _ScientificCalculatorContent();

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<ScientificCalculatorProvider>(context);
    final theme = Theme.of(context);
    final primaryColor = const Color(0xFF7C4DFF);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  calculator.isRadians ? 'RAD' : 'DEG',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
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
                      style: theme.textTheme.displayMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // Memory indicator
            if (calculator.memory != 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: primaryColor.withOpacity(0.1),
                child: Text(
                  'M: ${calculator.memory}',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            // Buttons
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      // Row 1: Memory & Mode
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: CalculatorButton(
                                text: 'MC',
                                onPressed: calculator.memoryClear,
                                backgroundColor: primaryColor.withOpacity(0.1),
                                textColor: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'MR',
                                onPressed: calculator.memoryRecall,
                                backgroundColor: primaryColor.withOpacity(0.1),
                                textColor: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'M+',
                                onPressed: calculator.memoryAdd,
                                backgroundColor: primaryColor.withOpacity(0.1),
                                textColor: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'M-',
                                onPressed: calculator.memorySubtract,
                                backgroundColor: primaryColor.withOpacity(0.1),
                                textColor: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: calculator.isRadians ? 'RAD' : 'DEG',
                                onPressed: calculator.toggleAngleMode,
                                backgroundColor: primaryColor.withOpacity(0.2),
                                textColor: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Row 2: Trig functions
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: CalculatorButton(
                                text: 'sin',
                                onPressed: () => calculator.appendFunction('sin'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'cos',
                                onPressed: () => calculator.appendFunction('cos'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'tan',
                                onPressed: () => calculator.appendFunction('tan'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'ln',
                                onPressed: () => calculator.appendFunction('ln'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'log',
                                onPressed: () => calculator.appendFunction('log'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Row 3: Powers & Roots
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: CalculatorButton(
                                text: 'x²',
                                onPressed: calculator.square,
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'x³',
                                onPressed: calculator.cube,
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: '√',
                                onPressed: calculator.squareRoot,
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: '∛',
                                onPressed: calculator.cubeRoot,
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'xʸ',
                                onPressed: () => calculator.appendOperator('^'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Row 4: Constants & Special
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: CalculatorButton(
                                text: 'π',
                                onPressed: () => calculator.appendConstant('π'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: 'e',
                                onPressed: () => calculator.appendConstant('e'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: '(',
                                onPressed: () => calculator.appendParenthesis('('),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: ')',
                                onPressed: () => calculator.appendParenthesis(')'),
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(
                              child: CalculatorButton(
                                text: '1/x',
                                onPressed: calculator.reciprocal,
                                backgroundColor: primaryColor.withOpacity(0.15),
                                textColor: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Row 5: C, ⌫, ÷
                      SizedBox(
                        height: 64,
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
                                text: '⌫',
                                onPressed: calculator.backspace,
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

                      // Row 6: 7, 8, 9, ×
                      SizedBox(
                        height: 64,
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

                      // Row 7: 4, 5, 6, -
                      SizedBox(
                        height: 64,
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

                      // Row 8: 1, 2, 3, +
                      SizedBox(
                        height: 64,
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

                      // Row 9: 0, ., =
                      SizedBox(
                        height: 64,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
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
            ),
          ],
        ),
      ),
    );
  }
}
