import 'package:injectable/injectable.dart';

import '../../../../core/abstract/typedefs.dart';
import '../entities/text_stats.dart';
import '../repositories/text_analyzer_repository.dart';

@lazySingleton
class AnalyzeTextUseCase {
  final TextAnalyzerRepository _repository;

  AnalyzeTextUseCase(this._repository);

  FutureEither<({int requestId, TextStats stats})> call({
    required String text,
    required int requestId,
  }) {
    return _repository.analyzeText(text: text, requestId: requestId);
  }
}
