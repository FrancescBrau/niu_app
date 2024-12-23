import 'package:flutter/material.dart';
import 'package:niu_app/config/const.dart';
import 'package:niu_app/features/auth/widgets/build_email_field.dart';
import 'package:niu_app/features/auth/widgets/build_message_text.dart';
import 'package:niu_app/features/auth/widgets/build_toggle_mode_button.dart';
import 'package:niu_app/features/auth/widgets/register_or_login_button.dart';
import 'package:niu_app/features/profile/screens/profile_screen.dart';
import 'package:niu_app/shared/repositories/shared_preferences.dart';
import 'package:niu_app/shared/utils.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen(
      {super.key, required this.toggleTheme, required this.isDarkTheme});

  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController emailController = TextEditingController();
  final repository = SharedPreferencesRepository();
  String message = '';
  bool isLoading = false;
  bool isRegisterMode = true;

  Future<void> registerOrLogin() async {
    final email = emailController.text.trim();

    if (!isValidEmail(email)) {
      _showMessage('Please, insert a valid email');
      return;
    }

    setState(() {
      isLoading = true;
    });

    if (isRegisterMode) {
      await _registerUser(email);
    } else {
      await _loginUser(email);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _registerUser(String email) async {
    final success = await repository.createUser(email);

    _showMessage(success
        ? 'User successfully registered. Redirecting to the profile...'
        : 'Error. User registered.');

    if (success) {
      _navigateToProfile(email);
    }
  }

  Future<void> _loginUser(String email) async {
    final userExists = await repository.readUser(email) != null;

    if (userExists) {
      _navigateToProfile(email);
    } else {
      _showMessage('User does not exist. Please register.');
    }
  }

  void _showMessage(String msg) {
    setState(() {
      message = msg;
    });
  }

  void _navigateToProfile(String email) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          email: email,
          toggleTheme: widget.toggleTheme,
          isDarkTheme: widget.isDarkTheme,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildEmailField(emailController: emailController),
            smallSpace,
            RegisterOrLoginButton(
                isLoading: isLoading,
                isRegisterMode: isRegisterMode,
                registerOrLogin: registerOrLogin),
            smallSpace,
            BuildToggleModeButton(
              isLoading: isLoading,
              isRegisterMode: isRegisterMode,
              onRegisterMode: () {
                setState(() {
                  isRegisterMode = !isRegisterMode;
                  message = '';
                });
              },
            ),
            smallSpace,
            BuildMessageText(message: message),
          ],
        ),
      ),
    );
  }
}
