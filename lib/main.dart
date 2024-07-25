import 'package:calculator/Provider_Screen/example1_Provider.dart';
import 'package:calculator/Provider_Screen/example2_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ResultModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => Datamodel(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 40, 39, 41)),
          useMaterial3: true,
        ),
        home: const Screen(),
        routes: {
          '/Screen': (context) => Screen(),
          '/calculator': (context) => const Calculator(),
          '/slider': (context) => const Slider_example(),
        },
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _InkWell(
              context,
              const Calculator(),
              "Calculator",
              Color.fromARGB(224, 80, 57, 57),
            ),
            const SizedBox(height: 20),
            _InkWell(
              context,
              const Slider_example(),
              "Slider",
              const Color.fromARGB(255, 15, 86, 104),
            ),
          ],
        ),
      ),
    );
  }

  Widget _InkWell(BuildContext context, Widget route, String txt, Color clr) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      child: Container(
          height: 20,
          width: 100,
          decoration: BoxDecoration(
              color: clr,
              border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text(txt))),
    );
  }
}
