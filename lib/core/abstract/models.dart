import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
