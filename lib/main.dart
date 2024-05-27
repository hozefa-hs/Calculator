import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
//responsive_sizer: ^3.3.0+1

void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      // brightness: Brightness.light,
      useMaterial3: true,
    ),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  String input = '';
  String output = '';
  String operation = '';
  bool hideInput = false;
  double outputSize = 35.0;

  @override
  Widget build(BuildContext context) {
    return MediaQuery
        .of(context)
        .orientation == Orientation.portrait
        ? _calculatorPotrait()
        : _calculatorLandscape();
  }

  _onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '⌫') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }

    setState(() {});
  }

  Widget button({text, textColor, btnBgColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => _onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: btnBgColor,
          ),
        ),
      ),
    );
  }

  Widget landscapeButton({text, textColor, btnBgColor}) {
    return Container(
      width: 120,
      height: 45,
      margin: EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () => _onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: btnBgColor,
        ),
      ),
    );
  }

  _calculatorPotrait() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          centerTitle: true,
          leading: Icon(Icons.arrow_back),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '' : input,
                      style: TextStyle(fontSize: 48),
                    ),
                    Text(
                      output,
                      style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  button(text: 'AC'),
                  button(text: '%'),
                  button(text: '⌫'),
                  button(text: '/'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  button(text: '7'),
                  button(text: '8'),
                  button(text: '9'),
                  button(text: 'x'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  button(text: '4'),
                  button(text: '5'),
                  button(text: '6'),
                  button(text: '-'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  button(text: '1'),
                  button(text: '2'),
                  button(text: '3'),
                  button(text: '+'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: Row(
                children: [
                  button(text: '00'),
                  button(text: '0'),
                  button(text: '.'),
                  button(
                    text: '=',
                    textColor: Colors.white,
                    btnBgColor: Theme
                        .of(context)
                        .primaryColorDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _calculatorLandscape() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        hideInput ? '' : input,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        output,
                        style: TextStyle(
                            fontSize: 25, color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  landscapeButton(text: 'AC'),
                  landscapeButton(text: '%'),
                  landscapeButton(text: '⌫'),
                  landscapeButton(text: '/'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  landscapeButton(text: '7'),
                  landscapeButton(text: '8'),
                  landscapeButton(text: '9'),
                  landscapeButton(text: 'x'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  landscapeButton(text: '4'),
                  landscapeButton(text: '5'),
                  landscapeButton(text: '6'),
                  landscapeButton(text: '-'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  landscapeButton(text: '1'),
                  landscapeButton(text: '2'),
                  landscapeButton(text: '3'),
                  landscapeButton(text: '+'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  landscapeButton(text: '00'),
                  landscapeButton(text: '0'),
                  landscapeButton(text: '.'),
                  landscapeButton(
                    text: '=',
                    textColor: Colors.white,
                    btnBgColor: Theme
                        .of(context)
                        .primaryColorDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
