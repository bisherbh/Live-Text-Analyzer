import 'package:syncrow_text_analyzer/core/constants/english_stop_words.dart';

class TextStats {
  final int wordCount;
  final int letterCount;
  final int whitespaceCount;
  final List<WordCount> topWords;

  const TextStats({
    required this.wordCount,
    required this.letterCount,
    required this.whitespaceCount,
    required this.topWords,
  });
}

class WordCount {
  final String word;
  final int count;

  const WordCount(this.word, this.count);
}

abstract final class TextAnalyzer {
  static const int defaultTopWordsLimit = 5;


  static final RegExp _whitespace = RegExp(r'\s');

  static final RegExp _countedCharacter = RegExp(r'[a-zA-Z,.]');

  static final RegExp _word = RegExp(r'[a-zA-Z]+');

  static TextStats analyze(
    String text, {
    int topWordsLimit = defaultTopWordsLimit,
    bool excludeStopWords = true,
  }) {
    final words = _extractWords(text);
    final wordsForFrequency = excludeStopWords
        ? _filterStopWords(words)
        : words;

    return TextStats(
      wordCount: words.length,
      letterCount: _countMatches(_countedCharacter, text),
      whitespaceCount: _countMatches(_whitespace, text),
      topWords: _topWords(wordsForFrequency, topWordsLimit),
    );
  }

  static int _countMatches(RegExp pattern, String text) =>
      pattern.allMatches(text).length;

  static List<String> _extractWords(String text) => _word
      .allMatches(text)
      .map((match) => match[0]!.toLowerCase())
      .toList(growable: false);

  static List<String> _filterStopWords(List<String> words) =>
      words.where((word) => !englishStopWords.contains(word)).toList(growable: false);

  static List<WordCount> _topWords(List<String> words, int limit) {
    final counts = <String, int>{};
    for (final word in words) {
      counts.update(word, (count) => count + 1, ifAbsent: () => 1);
    }

    final entries = counts.entries.toList()..sort(_byCountThenAlphabetical);

    return entries
        .take(limit)
        .map((e) => WordCount(e.key, e.value))
        .toList(growable: false);
  }

  static int _byCountThenAlphabetical(
    MapEntry<String, int> a,
    MapEntry<String, int> b,
  ) {
    final byCount = b.value.compareTo(a.value);
    return byCount != 0 ? byCount : a.key.compareTo(b.key);
  }
}
