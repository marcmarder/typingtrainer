import 'word.dart';
import 'lib.dart';

class IService {
  // Singleton
  static final IService _instance = IService._internal();
  factory IService() => _instance;
  IService._internal();

  List<String> _rawDictionary = [];
  List<Word> _dictionary = [];
  List<Word> _currentWords = [];

  List<Word> cycleWords(int count) {
    _currentWords = selectWords(_dictionary, count);
    return _currentWords;
  }

  Future<void> reset() async {
    _rawDictionary = [];
    _dictionary = [];
    _currentWords = [];

    _rawDictionary = await loadWords();
    _dictionary = _rawDictionary.map((e) => Word(e)).toList();
  }
}
