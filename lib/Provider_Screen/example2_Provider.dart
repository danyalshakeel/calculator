import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slider_example extends StatefulWidget {
  const Slider_example({super.key});

  @override
  State<Slider_example> createState() => _slider_exampleState();
}

// ignore: camel_case_types
class _slider_exampleState extends State<Slider_example> {
  @override
  Widget build(BuildContext context) {
    print("Bulid");
    //final model = Provider.of<Datamodel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Provider Example'),
        ),
        body: Consumer<Datamodel>(
          builder: (context, val, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Slider(
                    min: 0,
                    max: 1,
                    value: val.value,
                    onChanged: (value) {
                      val.setValue(value);
                    }),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.green.withOpacity(val.value),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.blue.withOpacity(val._value),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.redAccent.withOpacity(val._value),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ));
  }
}

class Datamodel with ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  void setValue(double value) {
    _value = value;
    notifyListeners();
  }
}
