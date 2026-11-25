import 'package:injectable/injectable.dart';
import 'package:syncrow_text_analyzer/core/extensions/text_stats_extension.dart';
import 'package:syncrow_text_analyzer/core/utils/text_analyzer.dart';

import '../../../../core/services/i_isolate_service.dart';
import '../models/text_analysis_request.dart';
import '../models/text_analysis_result_model.dart';

abstract class TextAnalyzerIsolateDatasource {
  Future<TextAnalysisResultModel> analyzeText(
    TextAnalysisRequest request, {
    bool simulateFailure = false,
  });
}

@LazySingleton(as: TextAnalyzerIsolateDatasource)
class TextAnalyzerIsolateDatasourceImpl
    implements TextAnalyzerIsolateDatasource {
  final IIsolateService _isolateService;

  TextAnalyzerIsolateDatasourceImpl(this._isolateService);

  @override
  Future<TextAnalysisResultModel> analyzeText(
    TextAnalysisRequest request, {
    bool simulateFailure = false,
  }) async {
    final stats = await _isolateService.run(
      _analyzeRequest,
      request,
      simulateFailure: simulateFailure,
    );

    return stats.toModel(request.requestId);
  }

  static TextStats _analyzeRequest(TextAnalysisRequest request) =>
      TextAnalyzer.analyze(
        request.text,
        excludeStopWords: request.excludeStopWords,
      );
}
