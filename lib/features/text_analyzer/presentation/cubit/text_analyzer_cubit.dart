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

  TextAnalyzerCubit(this._analyzeTextUseCase)
    : super(const TextAnalyzerState.initial()) {
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

  Future<void> simulateIsolateFailure() =>
      _processTextAnalysis('', simulateFailure: true);

  Future<void> _processTextAnalysis(
    String text, {
    bool simulateFailure = false,
  }) async {
    final requestId = DateTime.now().millisecondsSinceEpoch;
    _currentRequestId = requestId;

    emit(const TextAnalyzerState.loading());

    final resultEither = await _analyzeTextUseCase(
      text: text,
      requestId: requestId,
      simulateFailure: simulateFailure,
    );

    resultEither.fold(
      (failure) {
        if (requestId == _currentRequestId) {
          emit(TextAnalyzerState.failure(failure.message));
        }
      },
      (data) {
        if (data.requestId == _currentRequestId) {
          emit(TextAnalyzerState.success(data.stats));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _textSubscription?.cancel();
    _textSubject.close();
    return super.close();
  }
}
