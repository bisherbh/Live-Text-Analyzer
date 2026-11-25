import 'package:flutter_test/flutter_test.dart';
import 'package:syncrow_text_analyzer/core/utils/text_analyzer.dart';

void main() {
  group('TextAnalyzer Logic Tests', () {
    test('Counts words, letters, and whitespace correctly for standard text', () {
      final result = TextAnalyzer.analyze('Hello, world.');

      expect(result.wordCount, 2);
      expect(result.letterCount, 12);
      expect(result.whitespaceCount, 1);
      expect(result.topWords.length, 2);
      expect(result.topWords[0].word, 'hello');
      expect(result.topWords[1].word, 'world');
    });

    test('Handles empty and symbol-only text correctly', () {
      final emptyRes = TextAnalyzer.analyze('');

      expect(emptyRes.wordCount, 0);
      expect(emptyRes.letterCount, 0);
      expect(emptyRes.whitespaceCount, 0);
      expect(emptyRes.topWords, isEmpty);

      final symbolsRes = TextAnalyzer.analyze('123!@#');

      expect(symbolsRes.wordCount, 0);
      expect(symbolsRes.letterCount, 0);
      expect(symbolsRes.topWords, isEmpty);
    });
  });
}
