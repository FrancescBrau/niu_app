import 'package:flutter/material.dart';
import 'package:niu_app/features/global%20position%20/widgets/custom_card.dart';
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
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Icon(widget.isDarkTheme ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          CustomCard(
            title: 'Properties',
            description: 'Here you can find your appartments',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PropertieScreen(),
                ),
              );
            },
            imagePath: 'assets/images/vivendes.png',
          ),
          CustomCard(
            title: 'Alerts',
            description: 'Here you can manage your daily life as owner',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AlertScreen(),
                ),
              );
            },
            imagePath: 'assets/images/alert.png',
          ),
          CustomCard(
            title: 'Accounting',
            description: 'Here you can manage your creditors and debtors ',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            },
            imagePath: 'assets/images/conta.png',
          ),
          CustomCard(
            title: 'Contracts',
            description: 'Sign contracts and find all documents here',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContractScreen(),
                ),
              );
            },
            imagePath: 'assets/images/agreement.png',
          ),
          CustomCard(
            title: 'Mailbox',
            description: 'here you can chat with other contracting parties',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MailboxScreen(),
                ),
              );
            },
            imagePath: 'assets/images/misatge.png',
          )
        ],
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

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}

class MailboxScreen extends StatelessWidget {
  const MailboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}

class PropertieScreen extends StatelessWidget {
  const PropertieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
