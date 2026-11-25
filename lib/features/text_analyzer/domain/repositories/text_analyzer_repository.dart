import '../../../../core/abstract/typedefs.dart';
import '../entities/text_stats.dart';

abstract class TextAnalyzerRepository {
  FutureEither<({int requestId, TextStats stats})> analyzeText({
    required String text,
    required int requestId,
  });
}
