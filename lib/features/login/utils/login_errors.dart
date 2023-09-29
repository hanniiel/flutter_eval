/// from a firebase authentication exception code.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
String signUpFromCode(String code) {
  switch (code.toLowerCase()) {
    case 'invalid-email':
      return 'Email is not valid or badly formatted.';
    case 'user-disabled':
      return 'This user has been disabled. Please contact support for help.';
    case 'email-already-in-use':
      return 'An account already exists for that email.';
    case 'operation-not-allowed':
      return 'Operation is not allowed.  Please contact support.';
    case 'weak-password':
      return 'Please enter a stronger password.';
    default:
      return '';
  }
}

/// Create an authentication message
/// from a firebase authentication exception code.
String logInfromCode(String code) {
  switch (code.toLowerCase()) {
    case 'invalid_login_credentials':
      return 'Login credentials not match';
    case 'invalid-email':
      return 'Email is not valid or badly formatted.';
    case 'user-disabled':
      return 'This user has been disabled. Please contact support for help.';
    case 'user-not-found':
      return 'Email is not found, please create an account.';
    case 'wrong-password':
      return 'Incorrect password, please try again.';
    default:
      return '';
  }
}
