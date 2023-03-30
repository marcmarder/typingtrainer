class Word {
  String text;
  String? answer;

  bool get isCorrect => text == answer;

  int get length => text.length;

  Word(this.text);
}
