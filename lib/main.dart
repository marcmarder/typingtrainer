import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:typingtrainer/i_service.dart';
import 'package:typingtrainer/type_test_site.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Trainer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int wordCount = 50;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = wordCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isEmpty || int.parse(value) < 1) {
                    return;
                  }
                  wordCount = int.parse(value);
                },
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 32,
            ),
            FutureBuilder<void>(
              future: IService().reset(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return const Text('Error');
                }
                return FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        final words = IService().cycleWords(wordCount);
                        return TypeTestSite(words);
                      }));
                    },
                    label: Text("Start"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
