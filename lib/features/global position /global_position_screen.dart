import 'package:flutter/material.dart';
import 'package:niu_app/features/profile/profile_screen.dart';

class GlobalPositionScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  final String email;

  const GlobalPositionScreen({
    super.key,
    required this.email,
    required this.toggleTheme,
    required this.isDarkTheme,
  });

  @override
  State<GlobalPositionScreen> createState() => _GlobalPositionScreenState();
}

class _GlobalPositionScreenState extends State<GlobalPositionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Position'),
        actions: [
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Icon(widget.isDarkTheme ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
      ),
      body: const Center(
        child: Text('This is the Global Position Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  email: widget.email,
                  toggleTheme: widget.toggleTheme,
                  isDarkTheme: widget.isDarkTheme,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Global Position',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
