import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solvex/models/calculation_history.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider extends ChangeNotifier {
  String _display = '0';
  String _expression = '';
  bool _isNewCalculation = true;
  List<CalculationHistory> _history = [];

  String get display => _display;
  String get expression => _expression;
  List<CalculationHistory> get history => _history;

  CalculatorProvider() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('calculator_history') ?? [];
    _history = historyJson
        .map((json) => CalculationHistory.fromJson(jsonDecode(json)))
        .toList();
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = _history
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await prefs.setStringList('calculator_history', historyJson);
  }

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
      if ('+-×÷'.contains(lastChar)) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
      _expression += operator;
      _display = operator;
      _isNewCalculation = false;
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
        _display = _expression.split(RegExp(r'[+\-×÷]')).last;
        if (_display.isEmpty) {
          _display = _expression[_expression.length - 1];
        }
      }
      notifyListeners();
    }
  }

  void toggleSign() {
    if (_display != '0' && !_isNewCalculation) {
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else {
        _display = '-$_display';
      }
      final parts = _expression.split(RegExp(r'[+\-×÷]'));
      if (parts.isNotEmpty) {
        final lastPart = parts.last;
        _expression = _expression.substring(0, _expression.length - lastPart.length) + _display;
      }
      notifyListeners();
    }
  }

  void percentage() {
    if (_display != '0' && !_isNewCalculation) {
      try {
        final value = double.parse(_display);
        final result = value / 100;
        _display = _formatResult(result);
        _expression = _expression.substring(0, _expression.length - _display.length) + _display;
        notifyListeners();
      } catch (e) {
        // Invalid number
      }
    }
  }

  void calculate() {
    if (_expression.isEmpty) return;

    try {
      // Replace display operators with actual operators
      String evalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      Parser parser = Parser();
      Expression exp = parser.parse(evalExpression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      final formattedResult = _formatResult(result);

      // Save to history
      _history.insert(
        0,
        CalculationHistory(
          expression: _expression,
          result: formattedResult,
          timestamp: DateTime.now(),
        ),
      );
      _saveHistory();

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

  String _formatResult(double result) {
    if (result.isInfinite || result.isNaN) {
      return 'Error';
    }

    // Remove unnecessary decimal places
    if (result == result.toInt()) {
      return result.toInt().toString();
    }

    // Format with up to 10 decimal places, removing trailing zeros
    return result.toStringAsFixed(10).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  Future<void> clearHistory() async {
    _history.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('calculator_history');
    notifyListeners();
  }
}
