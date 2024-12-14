import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/base.dart';
import 'package:todo_app/views/Auth/login/login_connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {
  void login(String email, String password) async {
    try {
      connector!.showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (credential.user?.emailVerified == true) {
      //   onSuccess();
      // }
      connector!.hideLoading();
      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      connector!.hideLoading();
      connector!.showErrorDialog(e.toString());
    }
  }
}
