import '../entities/text_stats.dart';

abstract class TextAnalyzerRepository {
  Future<({int requestId, TextStats stats})> analyzeText({
    required String text,
    required int requestId,
  });
}
