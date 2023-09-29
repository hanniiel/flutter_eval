abstract class BaseLoginRepository {
  Future<void> login({required String email, required String password});
  Future<void> register({required String email, required String password});
}
