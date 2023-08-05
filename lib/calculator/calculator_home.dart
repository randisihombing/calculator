import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _currentNumber = "";
  String _previousNumber = "";
  String _operation = "";

  void _handleButtonPress(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentNumber = "";
        _previousNumber = "";
        _operation = "";
      } else if (value == "=") {
        _calculate();
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        _previousNumber = _currentNumber;
        _currentNumber = "";
        _operation = value;
      } else if (value == "sin" || value == "cos" || value == "tan") {
        _handleTrigonometric(value);
      } else {
        _currentNumber += value;
      }
      _output = _currentNumber;
    });
  }

  void _handleTrigonometric(String function) {
    double value = double.parse(_currentNumber);

    switch (function) {
      case "sin":
        _output = sin(value).toString();
        break;
      case "cos":
        _output = cos(value).toString();
        break;
      case "tan":
        _output = tan(value).toString();
        break;
      default:
        _output = "0";
    }

    _currentNumber = _output;
  }

  void _calculate() {
    String expression = _previousNumber + _operation + _currentNumber;
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();

    double result = exp.evaluate(EvaluationType.REAL, cm);

    _output = result.toString();
    _currentNumber = _output;
    _previousNumber = "";
    _operation = "";
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(buttonText),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("sin"),
              _buildButton("cos"),
              _buildButton("tan"),
              _buildButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("."),
            ],
          ),
        ],
      ),
    );
  }
}
