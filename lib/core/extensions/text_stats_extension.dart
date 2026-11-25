import 'package:syncrow_text_analyzer/features/text_analyzer/data/models/text_analysis_result_model.dart';
import 'package:syncrow_text_analyzer/features/text_analyzer/data/models/word_frequency_model.dart';

import '../utils/text_analyzer.dart';

extension TextStatsExtension on TextStats {
  TextAnalysisResultModel toModel(int requestId) => TextAnalysisResultModel(
    requestId: requestId,
    wordCount: wordCount,
    letterCount: letterCount,
    whitespaceCount: whitespaceCount,
    topWords: topWords
        .map((w) => WordFrequencyModel(word: w.word, count: w.count))
        .toList(growable: false),
  );
}
