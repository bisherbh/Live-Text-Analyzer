import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/text_stats.dart';

part 'text_analyzer_state.freezed.dart';

@freezed
class TextAnalyzerState with _$TextAnalyzerState {
  const factory TextAnalyzerState.initial() = _Initial;
  const factory TextAnalyzerState.loading() = _Loading;
  const factory TextAnalyzerState.success(TextStats stats) = _Success;
  const factory TextAnalyzerState.failure(String message) = _Failure;
}
