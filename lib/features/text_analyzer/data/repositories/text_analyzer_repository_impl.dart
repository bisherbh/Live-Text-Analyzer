import 'package:injectable/injectable.dart';

import '../../domain/entities/text_stats.dart';
import '../../domain/repositories/text_analyzer_repository.dart';
import '../datasources/text_analyzer_isolate_datasource.dart';
import '../models/text_analysis_request.dart';

@LazySingleton(as: TextAnalyzerRepository)
class TextAnalyzerRepositoryImpl implements TextAnalyzerRepository {
  final TextAnalyzerIsolateDatasource _datasource;

  TextAnalyzerRepositoryImpl(this._datasource);

  @override
  Future<({int requestId, TextStats stats})> analyzeText({
    required String text,
    required int requestId,
  }) async {
    final result = await _datasource.analyzeText(
      TextAnalysisRequest(text: text, requestId: requestId),
    );
    return (requestId: result.requestId, stats: result.toEntity());
  }
}
