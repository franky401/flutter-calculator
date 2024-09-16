import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator - Your Name',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[800],
          ),
        ),
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _expression = '';
  String _result = '';

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '';
      } else if (text == '=') {
        try {
          final expression = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _result = result.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += text;
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(text),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color ?? Colors.grey[800],
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Franky\'s Flutter Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression,
                      style:
                          const TextStyle(fontSize: 32, color: Colors.white70),
                    ),
                    Text(
                      _result,
                      style: const TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/', color: Colors.orange),
              ],
            ),
            Row(
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*', color: Colors.orange),
              ],
            ),
            Row(
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-', color: Colors.orange),
              ],
            ),
            Row(
              children: [
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('C',
                    color: const Color.fromARGB(222, 244, 67, 54)),
                _buildButton('+', color: Colors.orange),
              ],
            ),
            Row(
              children: [
                _buildButton('=', color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
