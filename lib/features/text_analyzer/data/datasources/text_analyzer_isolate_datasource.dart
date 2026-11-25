import 'package:injectable/injectable.dart';

import '../../../../core/services/i_isolate_service.dart';
import '../models/text_analysis_request.dart';
import '../models/text_analysis_result_model.dart';
import '../models/word_frequency_model.dart';

abstract class TextAnalyzerIsolateDatasource {
  Future<TextAnalysisResultModel> analyzeText(TextAnalysisRequest request);
}

@LazySingleton(as: TextAnalyzerIsolateDatasource)
class TextAnalyzerIsolateDatasourceImpl implements TextAnalyzerIsolateDatasource {
  final IIsolateService _isolateService;

  TextAnalyzerIsolateDatasourceImpl(this._isolateService);

  @override
  Future<TextAnalysisResultModel> analyzeText(TextAnalysisRequest request) {
    return _isolateService.run(analyzeTextInIsolate, request);
  }

  static TextAnalysisResultModel analyzeTextInIsolate(TextAnalysisRequest request) {
    final text = request.text;
    final requestId = request.requestId;

    if (text.isEmpty) {
      return TextAnalysisResultModel(
        requestId: requestId,
        wordCount: 0,
        letterCount: 0,
        whitespaceCount: 0,
        topWords: const [],
      );
    }

    final whitespaceCount = RegExp(r'\s').allMatches(text).length;

    // Counts A-Z/a-z letters as well as commas (,) and dots (.) as characters
    final letterCount = RegExp(r'[a-zA-Z,.]').allMatches(text).length;

    // Words consist strictly of A-Z/a-z characters
    final wordRegExp = RegExp(r'[a-zA-Z]+');
    final matches = wordRegExp.allMatches(text);

    final Map<String, int> frequencyMap = {};
    int totalWords = 0;

    for (final match in matches) {
      final rawWord = match.group(0);
      if (rawWord == null || rawWord.isEmpty) continue;

      final cleanedWord = rawWord.toLowerCase();

      totalWords++;
      frequencyMap[cleanedWord] = (frequencyMap[cleanedWord] ?? 0) + 1;
    }

    final sortedEntries = frequencyMap.entries.toList()
      ..sort((a, b) {
        final countComparison = b.value.compareTo(a.value);
        if (countComparison != 0) return countComparison;
        return a.key.compareTo(b.key);
      });

    final top5 = sortedEntries
        .take(5)
        .map((e) => WordFrequencyModel(word: e.key, count: e.value))
        .toList();

    return TextAnalysisResultModel(
      requestId: requestId,
      wordCount: totalWords,
      letterCount: letterCount,
      whitespaceCount: whitespaceCount,
      topWords: top5,
    );
  }
}
