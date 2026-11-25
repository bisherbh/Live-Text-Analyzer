import 'dart:async';
import 'dart:isolate';
import 'package:injectable/injectable.dart';

import '../errors/failures.dart';
import 'i_isolate_service.dart';

@LazySingleton(as: IIsolateService)
class IsolateService implements IIsolateService {
  @override
  Future<R> run<T, R>(
    R Function(T message) computation,
    T message, {
    bool simulateFailure = false,
  }) async {
    try {
      return await Isolate.run<R>(() {
        if (simulateFailure) {
          throw StateError('Simulated isolate failure');
        }
        return computation(message);
      });
    } catch (e) {
      throw IsolateFailure('Isolate error: $e');
    }
  }
}
