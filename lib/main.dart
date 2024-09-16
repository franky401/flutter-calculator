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
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _display = '';

  void _onPressed(String text) {
    setState(() {
      _display += text;
    });
  }

  void _squareNumber() {
    setState(() {
      double number = double.tryParse(_display) ?? 0;
      _display = (number * number).toString();
    });
  }

  void _modulus() {
    setState(() {
      List<String> parts = _display.split('%');
      if (parts.length == 2) {
        double num1 = double.tryParse(parts[0]) ?? 0;
        double num2 = double.tryParse(parts[1]) ?? 1;
        _display = (num1 % num2).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                _display,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _onPressed('1'),
                child: Text('1'),
              ),
              ElevatedButton(
                onPressed: () => _onPressed('2'),
                child: Text('2'),
              ),
              ElevatedButton(
                onPressed: () => _onPressed('3'),
                child: Text('3'),
              ),
              ElevatedButton(
                onPressed: _squareNumber,
                child: Text('x²'),
              ),
              ElevatedButton(
                onPressed: () => _onPressed('%'),
                child: Text('%'),
              ),
              ElevatedButton(
                onPressed: _modulus,
                child: Text('='),
              ),
            ],
          ),
          // Add more buttons as needed
        ],
      ),
    );
  }
}
