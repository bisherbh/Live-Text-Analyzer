abstract class IIsolateService {
  Future<R> run<T, R>(R Function(T message) computation, T message);
}
