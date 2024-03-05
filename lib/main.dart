import 'package:ccavenue_payment/cc_avenue_web.dart';
import 'package:flutter/material.dart';

import 'cc_avenue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var response = await CcAvenueService().fetchMerchantEncryptedData(1);
          if (response != null) {
            if (response.statusMessage == "SUCCESS") {
              print(response);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CcAvenueWeb(),));
            } else {
              print(response);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please try again.")));
            }
          } else {
            print("error");
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
