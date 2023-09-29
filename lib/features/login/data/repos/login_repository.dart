import 'package:flutter_eval/features/login/domain/repos/base_login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eval/features/shared/data/models/response.dart';
import 'package:flutter_eval/features/shared/data/models/user_model.dart';

class LoginRepository implements BaseLoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///response not required but implemented as requirement (part 5)
  @override
  Future<Response<UserModel?>> login(
      {required String email, required String password}) async {
    final res = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return Response(
      message: 'Logged In successfuly',
      data: UserModel.fromFirebase(res.user!),
      code: 200,
    );
  }

  @override
  Future<Response<UserModel?>> register(
      {required String email, required String password}) async {
    final res = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return Response(
      message: 'Registered successfuly',
      data: UserModel.fromFirebase(res.user!),
      code: 200,
    );
  }
}
