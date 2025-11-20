import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../../services/local_storage.dart';

enum CalculatorMode { standard, scientific }

class CalculatorController with ChangeNotifier {
  String _display = '0';
  String _expression = '';
  String _result = '';
  CalculatorMode _mode = CalculatorMode.standard;
  bool _isNewCalculation = true;
  double _memory = 0;
  bool _isRadians = true;

  final LocalStorageService _storageService = LocalStorageService();

  // Getters
  String get display => _display;
  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  bool get isRadians => _isRadians;
  double get memory => _memory;
  bool get hasMemory => _memory != 0;

  // Toggle between Standard and Scientific mode
  void toggleMode() {
    _mode = _mode == CalculatorMode.standard
        ? CalculatorMode.scientific
        : CalculatorMode.standard;
    notifyListeners();
  }

  // Toggle between Radians and Degrees
  void toggleAngleUnit() {
    _isRadians = !_isRadians;
    notifyListeners();
  }

  // Handle button press
  void onButtonPressed(String value) {
    if (_isNewCalculation && !_isOperator(value) && value != 'C' && value != '⌫') {
      _display = '';
      _expression = '';
      _result = '';
      _isNewCalculation = false;
    }

    switch (value) {
      case 'C':
        _clear();
        break;
      case '⌫':
        _backspace();
        break;
      case '=':
        _calculate();
        break;
      case '+/-':
        _toggleSign();
        break;
      case '%':
        _percentage();
        break;
      case 'MC':
        _memoryClear();
        break;
      case 'MR':
        _memoryRecall();
        break;
      case 'M+':
        _memoryAdd();
        break;
      case 'M-':
        _memorySubtract();
        break;
      case 'sin':
      case 'cos':
      case 'tan':
      case 'asin':
      case 'acos':
      case 'atan':
      case 'ln':
      case 'log':
      case '√':
      case '∛':
      case 'x²':
      case 'x³':
        _handleScientificFunction(value);
        break;
      case 'π':
        _appendValue(pi.toString());
        break;
      case 'e':
        _appendValue(e.toString());
        break;
      case '^':
        _appendOperator('^');
        break;
      default:
        if (_isOperator(value)) {
          _appendOperator(value);
        } else {
          _appendValue(value);
        }
    }

    notifyListeners();
  }

  void _clear() {
    _display = '0';
    _expression = '';
    _result = '';
    _isNewCalculation = true;
  }

  void _backspace() {
    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
      _expression = _expression.substring(0, _expression.length - 1);
    } else {
      _display = '0';
      _expression = '';
    }
  }

  void _appendValue(String value) {
    if (_display == '0' && value != '.') {
      _display = value;
      _expression = value;
    } else if (value == '.' && _display.contains('.')) {
      // Don't add another decimal point
      return;
    } else {
      _display += value;
      _expression += value;
    }
  }

  void _appendOperator(String operator) {
    if (_expression.isEmpty) return;

    // Check if last character is an operator
    final lastChar = _expression[_expression.length - 1];
    if (_isOperator(lastChar)) {
      // Replace the last operator
      _expression = _expression.substring(0, _expression.length - 1) + operator;
      _display = operator;
    } else {
      _expression += operator;
      _display = operator;
    }
  }

  bool _isOperator(String value) {
    return ['+', '-', '×', '÷', '/', '*', '^', '(', ')'].contains(value);
  }

  void _toggleSign() {
    if (_display == '0' || _display.isEmpty) return;

    if (_display.startsWith('-')) {
      _display = _display.substring(1);
    } else {
      _display = '-$_display';
    }

    // Update expression
    if (_expression.isNotEmpty) {
      final parts = _expression.split(RegExp(r'[+\-×÷]'));
      if (parts.isNotEmpty) {
        final lastPart = parts.last;
        if (lastPart.startsWith('-')) {
          _expression = _expression.substring(0, _expression.length - lastPart.length) +
              lastPart.substring(1);
        } else {
          _expression = _expression.substring(0, _expression.length - lastPart.length) +
              '-$lastPart';
        }
      }
    }
  }

  void _percentage() {
    if (_display.isEmpty || _display == '0') return;

    try {
      final value = double.parse(_display);
      final percentValue = value / 100;
      _display = _formatResult(percentValue);
      _expression = _display;
    } catch (e) {
      _display = 'Error';
    }
  }

  void _calculate() {
    if (_expression.isEmpty) return;

    try {
      // Replace custom operators with standard ones
      String processedExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', pi.toString())
          .replaceAll('e', e.toString());

      // Parse and evaluate
      Parser parser = Parser();
      Expression exp = parser.parse(processedExpression);
      ContextModel cm = ContextModel();

      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      _result = _formatResult(evalResult);
      _display = _result;

      // Save to history
      _storageService.addToHistory(_expression, _result);

      _isNewCalculation = true;
    } catch (e) {
      _display = 'Error';
      _result = 'Error';
      _isNewCalculation = true;
    }
  }

  void _handleScientificFunction(String function) {
    if (_display.isEmpty || _display == '0') return;

    try {
      double value = double.parse(_display);
      double result;

      switch (function) {
        case 'sin':
          result = _isRadians ? sin(value) : sin(value * pi / 180);
          break;
        case 'cos':
          result = _isRadians ? cos(value) : cos(value * pi / 180);
          break;
        case 'tan':
          result = _isRadians ? tan(value) : tan(value * pi / 180);
          break;
        case 'asin':
          result = _isRadians ? asin(value) : asin(value) * 180 / pi;
          break;
        case 'acos':
          result = _isRadians ? acos(value) : acos(value) * 180 / pi;
          break;
        case 'atan':
          result = _isRadians ? atan(value) : atan(value) * 180 / pi;
          break;
        case 'ln':
          result = log(value);
          break;
        case 'log':
          result = log(value) / ln10;
          break;
        case '√':
          result = sqrt(value);
          break;
        case '∛':
          result = pow(value, 1 / 3).toDouble();
          break;
        case 'x²':
          result = pow(value, 2).toDouble();
          break;
        case 'x³':
          result = pow(value, 3).toDouble();
          break;
        default:
          return;
      }

      _display = _formatResult(result);
      _expression = _display;
      _result = _display;
      _isNewCalculation = true;
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
    }
  }

  // Memory operations
  void _memoryClear() {
    _memory = 0;
  }

  void _memoryRecall() {
    _display = _formatResult(_memory);
    _expression = _display;
  }

  void _memoryAdd() {
    try {
      final value = double.parse(_display);
      _memory += value;
    } catch (e) {
      // Ignore if not a valid number
    }
  }

  void _memorySubtract() {
    try {
      final value = double.parse(_display);
      _memory -= value;
    } catch (e) {
      // Ignore if not a valid number
    }
  }

  String _formatResult(double value) {
    // Remove trailing zeros and unnecessary decimal point
    if (value.isInfinite || value.isNaN) {
      return 'Error';
    }

    String result = value.toString();

    // Handle very large or very small numbers
    if (value.abs() > 1e15 || (value.abs() < 1e-6 && value != 0)) {
      return value.toStringAsExponential(6);
    }

    // Remove trailing zeros after decimal point
    if (result.contains('.')) {
      result = result.replaceAll(RegExp(r'\.?0+$'), '');
    }

    return result;
  }

  // Load expression from history
  void loadExpression(String expr) {
    _expression = expr;
    _display = expr;
    _isNewCalculation = false;
    notifyListeners();
  }
}
