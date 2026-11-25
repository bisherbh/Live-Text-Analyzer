import '../../domain/entities/text_stats.dart';
import 'word_frequency_model.dart';

class TextAnalysisResultModel {
  final int requestId;
  final int wordCount;
  final int letterCount;
  final int whitespaceCount;
  final List<WordFrequencyModel> topWords;

  const TextAnalysisResultModel({
    required this.requestId,
    required this.wordCount,
    required this.letterCount,
    required this.whitespaceCount,
    required this.topWords,
  });

  TextStats toEntity() {
    return TextStats(
      wordCount: wordCount,
      letterCount: letterCount,
      whitespaceCount: whitespaceCount,
      topWords: topWords,
    );
  }
}
