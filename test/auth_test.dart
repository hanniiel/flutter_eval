import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_eval/features/auth/ui/bloc/bloc_auth.dart';
import 'package:flutter_eval/features/shared/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';

void main() async {
  //TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  group('AuthBloc test', () {
    late BlocAuth blocAuth;

    setUpAll(() async {
      await Firebase.initializeApp();
      EquatableConfig.stringify = true;
      blocAuth = BlocAuth();
    });

    blocTest<BlocAuth, AuthState>(
      'emits Authenticated',
      build: () => blocAuth,
      act: (bloc) => bloc.add(Logged(userMock)),
      wait: const Duration(seconds: 5),
      expect: () => [
        Authenticated(userMock),
      ],
    );

    tearDown(() => blocAuth.close());
  });
}

final userMock = UserModel(name: 'Jason Bourne', email: 'test@gmail.com');

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}
