import 'package:todo_app/base.dart';

abstract class LoginConnector extends BaseConnector {
  Future<void> goToHome();
}
