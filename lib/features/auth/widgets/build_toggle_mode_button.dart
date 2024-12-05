import 'package:flutter/material.dart';

class BuildToggleModeButton extends StatelessWidget {
  const BuildToggleModeButton(
      {super.key,
      required this.isLoading,
      required this.isRegisterMode,
      required this.onRegisterMode});

  final bool isLoading;
  final bool isRegisterMode;
  final Function() onRegisterMode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: isLoading
            ? null
            : () {
                onRegisterMode();
              },
        child: Text(
          isRegisterMode
              ? 'Already have an account? Log in!'
              : 'No account yet? Register!',
        ),
      ),
    );
  }
}
