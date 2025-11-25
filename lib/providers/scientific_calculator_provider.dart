import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ScientificCalculatorProvider extends ChangeNotifier {
  String _display = '0';
  String _expression = '';
  bool _isNewCalculation = true;
  double _memory = 0;
  bool _isRadians = true;

  String get display => _display;
  String get expression => _expression;
  double get memory => _memory;
  bool get isRadians => _isRadians;

  void appendNumber(String number) {
    if (_isNewCalculation) {
      _display = number;
      _expression = number;
      _isNewCalculation = false;
    } else {
      if (_display == '0' && number != '.') {
        _display = number;
      } else {
        _display += number;
      }
      _expression += number;
    }
    notifyListeners();
  }

  void appendOperator(String operator) {
    if (_expression.isNotEmpty) {
      final lastChar = _expression[_expression.length - 1];
      if ('+-×÷^'.contains(lastChar)) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
      _expression += operator;
      _display = operator;
      _isNewCalculation = false;
    }
    notifyListeners();
  }

  void appendFunction(String function) {
    if (_isNewCalculation && _display != '0') {
      _expression = '$function($display)';
    } else {
      _expression += '$function(';
    }
    _display = function;
    _isNewCalculation = false;
    notifyListeners();
  }

  void appendParenthesis(String paren) {
    _expression += paren;
    _display = paren;
    _isNewCalculation = false;
    notifyListeners();
  }

  void appendConstant(String constant) {
    if (_isNewCalculation) {
      _expression = constant;
      if (constant == 'π') {
        _display = math.pi.toString();
      } else if (constant == 'e') {
        _display = math.e.toString();
      }
      _isNewCalculation = false;
    } else {
      _expression += constant;
      _display = constant;
    }
    notifyListeners();
  }

  void appendDecimal() {
    if (!_display.contains('.')) {
      if (_isNewCalculation || _display == '0') {
        _display = '0.';
        _expression = '0.';
        _isNewCalculation = false;
      } else {
        _display += '.';
        _expression += '.';
      }
      notifyListeners();
    }
  }

  void clear() {
    _display = '0';
    _expression = '';
    _isNewCalculation = true;
    notifyListeners();
  }

  void backspace() {
    if (_expression.isNotEmpty && !_isNewCalculation) {
      _expression = _expression.substring(0, _expression.length - 1);
      if (_expression.isEmpty) {
        _display = '0';
        _isNewCalculation = true;
      } else {
        final parts = _expression.split(RegExp(r'[+\-×÷^()]'));
        _display = parts.isNotEmpty && parts.last.isNotEmpty ? parts.last : '0';
      }
      notifyListeners();
    }
  }

  void toggleAngleMode() {
    _isRadians = !_isRadians;
    notifyListeners();
  }

  void calculate() {
    if (_expression.isEmpty) return;

    try {
      String evalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('^', '^')
          .replaceAll('π', math.pi.toString())
          .replaceAll('e', math.e.toString());

      // Handle trigonometric functions
      if (!_isRadians) {
        // Convert degrees to radians for trig functions
        evalExpression = _convertTrigToDegrees(evalExpression);
      }

      // Handle special functions
      evalExpression = _processSpecialFunctions(evalExpression);

      Parser parser = Parser();
      Expression exp = parser.parse(evalExpression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      final formattedResult = _formatResult(result);

      _display = formattedResult;
      _expression = formattedResult;
      _isNewCalculation = true;
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
      notifyListeners();
    }
  }

  String _convertTrigToDegrees(String expr) {
    // Convert degree to radian for trig functions
    final degToRad = '*(${math.pi}/180)';
    expr = expr.replaceAllMapped(
      RegExp(r'sin\(([^)]+)\)'),
      (match) => 'sin(${match.group(1)}$degToRad)',
    );
    expr = expr.replaceAllMapped(
      RegExp(r'cos\(([^)]+)\)'),
      (match) => 'cos(${match.group(1)}$degToRad)',
    );
    expr = expr.replaceAllMapped(
      RegExp(r'tan\(([^)]+)\)'),
      (match) => 'tan(${match.group(1)}$degToRad)',
    );
    return expr;
  }

  String _processSpecialFunctions(String expr) {
    // Handle square root
    expr = expr.replaceAllMapped(
      RegExp(r'√\(([^)]+)\)'),
      (match) => 'sqrt(${match.group(1)})',
    );

    // Handle ln (natural log)
    expr = expr.replaceAllMapped(
      RegExp(r'ln\(([^)]+)\)'),
      (match) => 'ln(${match.group(1)})',
    );

    // Handle log (base 10)
    expr = expr.replaceAllMapped(
      RegExp(r'log\(([^)]+)\)'),
      (match) => 'log(${match.group(1)})',
    );

    return expr;
  }

  String _formatResult(double result) {
    if (result.isInfinite || result.isNaN) {
      return 'Error';
    }

    if (result == result.toInt()) {
      return result.toInt().toString();
    }

    return result.toStringAsFixed(10).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  // Memory Operations
  void memoryAdd() {
    try {
      _memory += double.parse(_display);
      notifyListeners();
    } catch (e) {
      // Invalid number
    }
  }

  void memorySubtract() {
    try {
      _memory -= double.parse(_display);
      notifyListeners();
    } catch (e) {
      // Invalid number
    }
  }

  void memoryRecall() {
    _display = _formatResult(_memory);
    _expression = _display;
    _isNewCalculation = true;
    notifyListeners();
  }

  void memoryClear() {
    _memory = 0;
    notifyListeners();
  }

  // Special operations
  void square() {
    try {
      final value = double.parse(_display);
      final result = value * value;
      _display = _formatResult(result);
      _expression = _display;
      _isNewCalculation = true;
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
      notifyListeners();
    }
  }

  void cube() {
    try {
      final value = double.parse(_display);
      final result = value * value * value;
      _display = _formatResult(result);
      _expression = _display;
      _isNewCalculation = true;
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
      notifyListeners();
    }
  }

  void squareRoot() {
    try {
      final value = double.parse(_display);
      if (value < 0) {
        _display = 'Error';
      } else {
        final result = math.sqrt(value);
        _display = _formatResult(result);
        _expression = _display;
      }
      _isNewCalculation = true;
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
      notifyListeners();
    }
  }

  void cubeRoot() {
    try {
      final value = double.parse(_display);
      final result = math.pow(value, 1 / 3);
      _display = _formatResult(result.toDouble());
      _expression = _display;
      _isNewCalculation = true;
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
      notifyListeners();
    }
  }

  void factorial() {
    try {
      final value = int.parse(_display);
      if (value < 0 || value > 20) {
        _display = 'Error';
      } else {
        int result = 1;
        for (int i = 2; i <= value; i++) {
          result *= i;
        }
        _display = result.toString();
        _expression = _display;
      }
      _isNewCalculation = true;
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
      notifyListeners();
    }
  }

  void reciprocal() {
    try {
      final value = double.parse(_display);
      if (value == 0) {
        _display = 'Error';
      } else {
        final result = 1 / value;
        _display = _formatResult(result);
        _expression = _display;
      }
      _isNewCalculation = true;
      notifyListeners();
    } catch (e) {
      _display = 'Error';
      _isNewCalculation = true;
      notifyListeners();
    }
  }
}
