import 'dart:async';

import 'package:flutter/material.dart';
import 'package:typingtrainer/finished_page.dart';
import 'package:typingtrainer/word.dart';

class TypeTestSite extends StatefulWidget {
  const TypeTestSite(this.words, {super.key});

  final List<Word> words;

  @override
  State<TypeTestSite> createState() => _TypeTestSiteState();
}

class _TypeTestSiteState extends State<TypeTestSite> {
  late String text;
  bool onoff = false;
  String textAnswer = '';
  int charIndex = 0;
  Timer? timer;
  int millisecondsElapsed = 0;

  @override
  void initState() {
    text = widget.words.map((e) => e.text).join(' ');
    super.initState();
    _focusNode.requestFocus();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Color getCharColor(int index) {
    if (index >= textAnswer.length) {
      return Colors.grey;
    }
    return Colors.black;
  }

  Color getBackgroundColor(int index) {
    if (index >= textAnswer.length) {
      return Colors.transparent;
    }
    if (textAnswer[index] == text[index]) {
      return Colors.green;
    }
    return Colors.red;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        millisecondsElapsed += 100;
      });
    });
  }

  void onTextChange(String value) {
    if (isFinished()) {
      // push to finishedPage
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FinishedPage(widget.words, textAnswer, millisecondsElapsed);
      }));
    }

    setState(() {
      textAnswer = value;
      if (textAnswer.isEmpty) {
        charIndex = 0;
      } else {
        charIndex = textAnswer.length - 1;
      }
    });
  }

  bool isFinished() {
    return textAnswer.length == text.length && textAnswer == text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 0,
              height: 0,
              child: TextField(
                textInputAction: TextInputAction.none,
                onTapOutside: (event) {
                  _focusNode.requestFocus();
                },
                controller: _controller,
                focusNode: _focusNode,
                onChanged: (value) {
                  onTextChange(value);
                },
              ),
            ),
            Text(
                'Elapsed: ${(millisecondsElapsed / 1000).toStringAsPrecision(2)}',
                style: const TextStyle(fontSize: 30)),
            Container(
              margin: const EdgeInsets.all(50),
              child: RichText(
                  text: TextSpan(children: [
                for (var charIndex = 0; charIndex < text.length; charIndex++)
                  TextSpan(
                      text: text[charIndex],
                      style: TextStyle(
                          fontSize: 30,
                          color: getCharColor(charIndex),
                          backgroundColor: getBackgroundColor(charIndex)))
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
