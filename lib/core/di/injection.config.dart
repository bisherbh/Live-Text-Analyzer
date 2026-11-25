// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/text_analyzer/data/datasources/text_analyzer_isolate_datasource.dart'
    as _i269;
import '../../features/text_analyzer/data/repositories/text_analyzer_repository_impl.dart'
    as _i143;
import '../../features/text_analyzer/domain/repositories/text_analyzer_repository.dart'
    as _i388;
import '../../features/text_analyzer/domain/usecases/analyze_text_usecase.dart'
    as _i910;
import '../../features/text_analyzer/presentation/cubit/text_analyzer_cubit.dart'
    as _i180;
import '../services/i_isolate_service.dart' as _i660;
import '../services/isolate_service.dart' as _i548;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i660.IIsolateService>(() => _i548.IsolateService());
    gh.lazySingleton<_i269.TextAnalyzerIsolateDatasource>(
      () =>
          _i269.TextAnalyzerIsolateDatasourceImpl(gh<_i660.IIsolateService>()),
    );
    gh.lazySingleton<_i388.TextAnalyzerRepository>(
      () => _i143.TextAnalyzerRepositoryImpl(
        gh<_i269.TextAnalyzerIsolateDatasource>(),
      ),
    );
    gh.lazySingleton<_i910.AnalyzeTextUseCase>(
      () => _i910.AnalyzeTextUseCase(gh<_i388.TextAnalyzerRepository>()),
    );
    gh.factory<_i180.TextAnalyzerCubit>(
      () => _i180.TextAnalyzerCubit(gh<_i910.AnalyzeTextUseCase>()),
    );
    return this;
  }
}
