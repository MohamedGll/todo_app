import 'package:flutter/material.dart';

abstract class BaseConnector {
  void showLoading();
  void showErrorDialog(String message);
  void hideLoading();
}

class BaseViewModel<C extends BaseConnector> extends ChangeNotifier {
  C? connector;
}

abstract class BaseView<VM extends BaseViewModel, S extends StatefulWidget>
    extends State<S> implements BaseConnector {
  late VM viewModel;

  VM initMyViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initMyViewModel();
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showErrorDialog(String message) {
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
  }

  @override
  void showLoading() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
