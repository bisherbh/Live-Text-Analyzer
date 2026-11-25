import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class IsolateFailure extends Failure {
  const IsolateFailure([super.message = 'Isolate execution failed']);
}

class AnalysisFailure extends Failure {
  const AnalysisFailure([super.message = 'Text analysis failed']);
}
