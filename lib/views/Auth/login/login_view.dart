import 'package:flutter/material.dart';
import 'package:todo_app/base.dart';
import 'package:todo_app/views/Auth/login/login_connector.dart';
import 'package:todo_app/views/Auth/login/login_view_model.dart';
import 'package:todo_app/views/Auth/register_view.dart';
import 'package:todo_app/views/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseView<LoginViewModel, LoginView>
    implements LoginConnector {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Screen',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.red),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              style: const TextStyle(color: Colors.red),
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                viewModel.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RegisterView.id,
            );
          },
          child: const Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: "Can't have an account?? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "SignUp",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel initMyViewModel() {
    return LoginViewModel();
  }

  @override
  Future<void> goToHome() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeView.id,
      (route) => false,
    );
  }

  // @override
  // void hideLoading() {
  //   Navigator.pop(context);
  // }

  // @override
  // void showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text(
  //           'Error',
  //         ),
  //         content: Text(message),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {},
  //             child: const Text('Ok'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // @override
  // void showLoading() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Center(child: CircularProgressIndicator()),
  //       );
  //     },
  //   );
  // }
}
