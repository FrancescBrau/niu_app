import 'package:flutter/material.dart';

class RegisterOrLoginButton extends StatelessWidget {
  const RegisterOrLoginButton(
      {super.key,
      required this.isLoading,
      required this.isRegisterMode,
      required this.registerOrLogin});

  final bool isLoading;
  final bool isRegisterMode;
  final Function() registerOrLogin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: isLoading ? null : registerOrLogin(),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              )
            : Text(isRegisterMode ? 'Sing up' : 'Log in'),
      ),
    );
  }
}
