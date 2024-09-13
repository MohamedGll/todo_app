import 'package:flutter/material.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/views/Auth/register_view.dart';
import 'package:todo_app/views/home_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  static const String id = 'LoginView';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              style: TextStyle(color: Colors.red),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              style: TextStyle(color: Colors.red),
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
                FirebaseFunctions.login(
                    emailController.text, passwordController.text,
                    onSuccess: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeView.id,
                    (route) => false,
                  );
                }, onError: (message) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Error',
                        ),
                        content: Text(message),
                        actions: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                });
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
}
