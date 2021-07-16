import 'package:flutter/material.dart';
export 'global_snack_bar.dart';
import 'global_scaffold.dart';

class GlobalSnackBar {
  const GlobalSnackBar();

  Future<void> showSnackBar({
    required Widget child,
    required Duration duration,
  }) async {
    GlobalScaffold.instance.showSnackbar(
      SnackBar(
        duration: duration,
        content: child,
      ),
    );
  }

  Future<void> showErrorSnackbar(String message, {Duration? duration}) async {
    GlobalScaffold.instance.showSnackbar(
      SnackBar(
        duration: duration != null
            ? duration
            : Duration(
                seconds: 3,
              ),
        backgroundColor: Colors.black87,
        content: SizedBox(
          height: 50,
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> showSucessSnackbar(String message, {Duration? duration}) async {
    GlobalScaffold.instance.showSnackbar(
      SnackBar(
        elevation: 1,
        duration: duration != null
            ? duration
            : Duration(
                seconds: 1,
              ),
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.done,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
