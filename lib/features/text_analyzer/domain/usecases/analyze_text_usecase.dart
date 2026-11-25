import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/text_stats.dart';
import '../repositories/text_analyzer_repository.dart';

@lazySingleton
class AnalyzeTextUseCase {
  final TextAnalyzerRepository _repository;

  AnalyzeTextUseCase(this._repository);

  Future<Either<Failure, ({int requestId, TextStats stats})>> call({
    required String text,
    required int requestId,
  }) {
    return _repository.analyzeText(text: text, requestId: requestId);
  }
}
