import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eval/features/login/domain/repos/base_login_repository.dart';
import 'package:flutter_eval/features/login/utils/login_errors.dart';
import 'package:flutter_eval/features/shared/services/debug.dart';

class CubitLogin extends Cubit<LoginState> {
  final BaseLoginRepository _loginRepository;

  CubitLogin({required BaseLoginRepository repository})
      : _loginRepository = repository,
        super(LoginState.init());

  //extra field to store token but not required on FirebaseAuth
  void rememberMe() => emit(state.copyWith(rememberMe: !state.rememberMe));
  //bool to change pages related to login signup
  void isRegister() => emit(state.copyWith(isRegister: !state.isRegister));

  void login({required String email, required password}) async {
    try {
      emit(state.copyWith(loading: true, success: false));
      await _loginRepository.login(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final msg = logInfromCode(e.code);
      emit(state.copyWith(loading: false, message: msg));
    } catch (e) {
      debug.e(e);
    } finally {
      emit(state.copyWith(loading: false, success: false));
    }
  }

  void register({required String email, required password}) async {
    try {
      emit(state.copyWith(loading: true, success: false));
      await _loginRepository.register(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final msg = signUpFromCode(e.code);
      emit(state.copyWith(loading: false, message: msg));
    } catch (e) {
      debug.e('error $e');
    } finally {
      emit(state.copyWith(loading: false, success: false));
    }
  }
}

//simplifieed login state
class LoginState {
  final bool loading, isRegister;
  final String? message;

  final bool rememberMe;
  final bool success;

  LoginState({
    this.rememberMe = false,
    this.loading = false,
    this.message,
    this.success = false,
    this.isRegister = false,
  });

  factory LoginState.init() => LoginState();

  LoginState copyWith({
    bool? loading,
    String? message,
    bool? passwordValid,
    bool? emailValid,
    bool? success,
    bool? rememberMe,
    bool? isRegister,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      success: success ?? this.success,
      rememberMe: rememberMe ?? this.rememberMe,
      isRegister: isRegister ?? this.isRegister,
    );
  }
}
