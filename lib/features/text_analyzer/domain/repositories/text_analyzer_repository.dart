import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/text_stats.dart';

abstract class TextAnalyzerRepository {
  Future<Either<Failure, ({int requestId, TextStats stats})>> analyzeText({
    required String text,
    required int requestId,
  });
}
