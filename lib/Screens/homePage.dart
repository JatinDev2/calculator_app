import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';
import '../CustomComponents/buttons.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  final List<String> buttons = [
    'C', '(', ')', 'DEL', '7', '8', '9', '/', '4', '5', '6', 'x', '1', '2', '3', '-', '0', '.', '=', '+',
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690),);

    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator", style: TextStyle(color: Colors.white, fontSize: 20.sp)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      backgroundColor: Colors.teal[50],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.w),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 24.sp, color: Colors.black54),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.w),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(fontSize: 30.sp, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {

                bool isOperator = ['/', 'x', '-', '+', '=', 'C', '(', ')', 'DEL'].contains(buttons[index]);
                Color? buttonColor = isOperator ? Colors.teal[300] : Colors.teal[100];
                Color? textColor = isOperator ? Colors.white : Colors.teal[900];

                return MyButton(
                  buttontapped: () {
                    setState(() {
                      if (index == 0) {
                        userInput = '';
                        answer = '0';
                      } else if (index == 18) {
                        equalPressed();
                      } else {
                        userInput += buttons[index];
                        if (index == 3 && userInput.isNotEmpty) {
                          userInput = userInput.substring(0, userInput.length - 1);
                        }
                      }
                    });
                  },
                  buttonText: buttons[index],
                  color: buttonColor,
                  textColor: textColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
