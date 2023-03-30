import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:typingtrainer/word.dart';

Future<List<String>> loadWords() async {
  const url =
      'https://raw.githubusercontent.com/sindresorhus/word-list/main/words.txt';
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  if (response.statusCode != 200) {
    throw HttpException(
      'Unexpected status code ${response.statusCode}:'
      ' $responseBody',
      uri: Uri.parse(url),
    );
  }
  final words = responseBody.split('\n');
  if (words.isEmpty) {
    throw HttpException(
      'No words found at $url',
      uri: Uri.parse(url),
    );
  }
  return words;
}

List<Word> selectWords(List<Word> words, int count) {
  final random = Random();
  final selectedWords = <Word>[];
  for (var i = 0; i < count; i++) {
    selectedWords.add(words[random.nextInt(words.length)]);
  }
  return selectedWords;
}
