import 'package:flutter/material.dart';
import 'package:niu_app/features/global%20position%20/features/account_screen.dart';
import 'package:niu_app/features/global%20position%20/features/contract_screen.dart';
import 'package:niu_app/features/global%20position%20/features/mailbox_screen.dart';
import 'package:niu_app/features/global%20position%20/features/propertie_screen.dart';

import '../../profile/screens/profile_screen.dart';
import '../features/alert_screen.dart';
import '../widgets/custom_card.dart';

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
