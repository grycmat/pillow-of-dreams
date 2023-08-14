// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'register.module.dart' as _i7;
import 'services/gpt.service.dart' as _i6;
import 'services/http.service.dart' as _i5;
import 'state/conversation.state.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.ConversationState>(_i3.ConversationState());
    gh.factory<_i4.Dio>(() => registerModule.dio);
    gh.singleton<_i5.HttpService>(_i5.HttpService(
      dio: gh<_i4.Dio>(),
      conversationState: gh<_i3.ConversationState>(),
    ));
    gh.singleton<_i6.GptService>(_i6.GptService(http: gh<_i5.HttpService>()));
    return this;
  }
}

class _$RegisterModule extends _i7.RegisterModule {}
