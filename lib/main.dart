import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResultModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 40, 39, 41)),
          useMaterial3: true,
        ),
        home: const Calculator(),
      ),
    );
  }
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text("Calculator"),
      ),
      body: Card(
        color: Colors.grey[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Calculator",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            _TextFieldWidget(),
            _DropDownWidget(),
            _TextFieldWidget(isSecondField: true),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 0, 0, 0),
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            _ButtonWidget(),
            const SizedBox(
              height: 20,
            ),
            _ResultWidget(),
          ],
        ),
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final bool isSecondField;
  const _TextFieldWidget({this.isSecondField = false, super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ResultModel>(context, listen: false);
    return TextField(
      controller: isSecondField ? model.controller2 : model.controller1,
      cursorHeight: 20,
      cursorColor: Colors.black,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 24, 22, 22),
      ),
      decoration: const InputDecoration(
        labelText: 'Number',
        hintText: "Enter a number",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 6, 2, 2)),
        ),
      ),
    );
  }
}

class _DropDownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResultModel>(
      builder: (context, model, child) {
        return DropdownButton<String>(
          dropdownColor: Colors.grey[300],
          value: model.op,
          onChanged: (value) {
            model.setOperator(value!);
          },
          items: const [
            DropdownMenuItem(value: "+", child: Text('+')),
            DropdownMenuItem(value: "-", child: Text('-')),
            DropdownMenuItem(value: "*", child: Text('*')),
            DropdownMenuItem(value: "/", child: Text('/')),
          ],
        );
      },
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ResultModel>(context, listen: false);
    return InkWell(
      onTap: model.calculate,
      child: Container(
        height: 35,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Calculate",
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

class _ResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResultModel>(
      builder: (context, model, child) {
        return Text(
          model.result,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        );
      },
    );
  }
}

class ResultModel with ChangeNotifier {
  double number1 = 0.0;
  double number2 = 0.0;
  String op = '+';
  String result = '';
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  void setOperator(String operator) {
    op = operator;
    notifyListeners();
  }

  void calculate() {
    try {
      number1 = double.parse(controller1.text);
      number2 = double.parse(controller2.text);
    } catch (e) {
      result = 'Error: Invalid number';
      notifyListeners();
      return;
    }

    if (controller1.text.isNotEmpty &&
        controller2.text.isNotEmpty &&
        (op == "+" || op == "-" || op == "*" || op == "/")) {
      switch (op) {
        case "+":
          result = (number1 + number2).toString();
          break;
        case "-":
          result = (number1 - number2).toString();
          break;
        case "*":
          result = (number1 * number2).toString();
          break;
        case "/":
          if (number2 == 0) {
            result = 'Error: Division by zero';
          } else {
            result = (number1 / number2).toString();
          }
          break;
        default:
          result = 'Error: Invalid operator';
          break;
      }
    }
    notifyListeners();
  }
}
