import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eval/features/shared/data/models/user_model.dart';
import 'package:flutter_eval/features/shared/services/debug.dart';

class BlocAuth extends Bloc<AuthEvent, AuthState> {
  //AbstractLoginRepository repository;
  final FirebaseAuth _firebaseAuth;
  StreamSubscription? _streamSubscription;

  factory BlocAuth.instance(FirebaseAuth auth) => BlocAuth(firebaseAuth: auth);

  BlocAuth({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(Unauthenticated()) {
    //On app started suscribe to auth events
    on<Initialized>((event, emit) {
      try {
        emit(Authenticating());
        _streamSubscription =
            _firebaseAuth.authStateChanges().listen((firebaseUser) {
          if (firebaseUser != null) {
            final user = UserModel.fromFirebase(firebaseUser);
            add(Logged(user));
          } else {
            add(LogOut());
          }
        });
      } catch (e) {
        debug.e(e);
      }
    });
    //get user from event and emit state
    on<Logged>((event, emit) {
      emit(Authenticated(event.user));
    });

    //log out and emit state
    on<LogOut>((event, emit) async {
      await _firebaseAuth.signOut();
      emit(Unauthenticated());
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

//States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Error extends AuthState {}

//Events
abstract class AuthEvent {
  const AuthEvent();
}

class Initialized extends AuthEvent {}

class Logged extends AuthEvent {
  final UserModel user;
  Logged(this.user);
}

class LogOut extends AuthEvent {}
