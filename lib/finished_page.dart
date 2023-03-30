import 'package:flutter/material.dart';
import 'package:typingtrainer/word.dart';

class FinishedPage extends StatelessWidget {
  FinishedPage(this.words, this.answer, this.millisecondsElapsed, {Key? key})
      : super(key: key);
  late List<Word> words = [];
  late String answer = '';
  late int millisecondsElapsed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  style: const TextStyle(fontSize: 30, color: Colors.black),
                  children: [
                TextSpan(
                  text: "Seconds elapsed: ${millisecondsElapsed / 1000} \n",
                ),
                TextSpan(
                  text: "Words: ${words.length} \n",
                ),
                TextSpan(
                    text:
                        "WPM: ${((words.length / (millisecondsElapsed / 1000)) * 60).toStringAsPrecision(2)}\n"),
              ])),
          Container(
            height: 32,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              label: const Text('Restart'))
        ],
      )),
    );
  }
}
