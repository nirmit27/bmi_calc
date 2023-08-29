import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const MyHomePage(title: 'Your BMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();

  // for holding the results ...
  var msg = "", result = "";

  // for changing the bg. color according to BMI value ...
  Color? _bmiColor = Colors.white;

  // for Form Validation ...
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: _bmiColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Body Mass Index",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 21,
                ),
                TextFormField(
                  controller: wtController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the requested details.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter your weight (in Kgs.)",
                    hintText: 'e.g. 50',
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 11,
                ),
                TextFormField(
                  controller: ftController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the requested details.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter your height (in Feet)",
                    hintText: "e.g. 5",
                    prefixIcon: Icon(Icons.boy_rounded),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 11,
                ),
                TextFormField(
                  controller: inController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the requested details.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter your height (in Inches)",
                    hintText: "e.g. 6",
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 25,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          wtController.text = "";
                          ftController.text = "";
                          inController.text = "";
                          msg = "";
                          result = "";
                          _bmiColor = Colors.white;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        elevation: 2.0,
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var wt = int.parse(wtController.text);
                        var ft = int.parse(ftController.text);
                        var inc = int.parse(inController.text);

                        if (_formKey.currentState!.validate()) {
                          var totalM = (((ft * 12) + inc) * (2.54)) / 100;

                          var bmi = wt / pow(totalM, 2);

                          if (bmi > 25) {
                            msg = "You are Overweight. 🥲";
                            _bmiColor = Colors.orange.shade500;
                          } else if (bmi < 18) {
                            msg = "You are Underweight. 😶";
                            _bmiColor = Colors.red.shade500;
                          } else {
                            msg = "You are Healthy. 😄";
                            _bmiColor = Colors.green.shade200;
                          }

                          setState(() {
                            result = "Your BMI is ${bmi.toStringAsFixed(4)}";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        elevation: 2.0,
                      ),
                      child: const Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  result,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  msg,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
