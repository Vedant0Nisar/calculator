import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var displayText = ''.obs; // For displaying user inputs and results
  var lastValue = ''.obs; // To store the last valid result

  /// Appends a value to the display or performs actions
  void appendValue(String value) {
    if (value == 'AC') {
      clear();
    } else if (value == '=') {
      calculate();
    } else if (value == '±') {
      toggleSign();
    } else if (value == '%') {
      calculatePercentage();
    } else {
      // Prevent adding multiple consecutive operators
      if (_isOperator(value) &&
          displayText.value.isNotEmpty &&
          _isOperator(displayText.value[displayText.value.length - 1])) {
        displayText.value =
            displayText.value.substring(0, displayText.value.length - 1) +
                value;
      } else {
        displayText.value += value;
      }
    }
  }

  /// Clears the current display
  void clear() {
    displayText.value = '';
    lastValue.value = '';
  }

  /// Toggles the sign of the current value
  void toggleSign() {
    if (displayText.value.isNotEmpty) {
      try {
        double current = double.parse(displayText.value);
        displayText.value = (-current).toString();
      } catch (e) {
        displayText.value = 'Error';
      }
    }
  }

  /// Calculates the percentage of the current value
  void calculatePercentage() {
    if (displayText.value.isNotEmpty) {
      try {
        double current = double.parse(displayText.value);
        displayText.value = (current / 100).toString();
      } catch (e) {
        displayText.value = 'Error';
      }
    }
  }

  /// Calculates the result of the expression
  void calculate() {
    try {
      final expression = displayText.value;
      final result = _evaluateExpression(expression);
      displayText.value = result
          .toString()
          .replaceAll(RegExp(r'\.0+$'), ''); // Remove trailing .0
      lastValue.value = displayText.value; // Store the last result
    } catch (e) {
      displayText.value = 'Error';
    }
  }

  /// Evaluates the mathematical expression using `math_expressions`
  double _evaluateExpression(String expression) {
    try {
      Parser parser = Parser();
      Expression exp =
          parser.parse(expression.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel contextModel = ContextModel();
      return exp.evaluate(EvaluationType.REAL, contextModel);
    } catch (e) {
      throw Exception('Invalid Expression');
    }
  }

  /// Checks if a character is an operator
  bool _isOperator(String value) {
    return ['+', '-', '*', '/', '×', '÷'].contains(value);
  }
}
