import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/analyze_text_usecase.dart';
import 'text_analyzer_state.dart';

@injectable
class TextAnalyzerCubit extends Cubit<TextAnalyzerState> {
  final AnalyzeTextUseCase _analyzeTextUseCase;
  final _textSubject = PublishSubject<String>();
  StreamSubscription? _textSubscription;

  int _currentRequestId = 0;

  TextAnalyzerCubit(this._analyzeTextUseCase) : super(const TextAnalyzerState.initial()) {
    _setupDebounceStream();
    onTextChanged('');
  }

  void _setupDebounceStream() {
    _textSubscription = _textSubject
        .debounceTime(const Duration(milliseconds: 300))
        .listen(_processTextAnalysis);
  }

  void onTextChanged(String text) {
    _textSubject.add(text);
  }

  Future<void> _processTextAnalysis(String text) async {
    _currentRequestId++;
    final requestId = _currentRequestId;

    emit(const TextAnalyzerState.loading());

    try {
      final result = await _analyzeTextUseCase(
        text: text,
        requestId: requestId,
      );

      if (result.requestId == _currentRequestId) {
        emit(TextAnalyzerState.success(result.stats));
      }
    } catch (e) {
      if (requestId == _currentRequestId) {
        emit(TextAnalyzerState.failure('Text analysis failed: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    _textSubscription?.cancel();
    _textSubject.close();
    return super.close();
  }
}
