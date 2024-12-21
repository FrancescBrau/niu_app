import 'package:flutter/material.dart';
import 'package:niu_app/features/profile/widgets/address.dart';
import 'package:niu_app/features/profile/widgets/city.dart';
import 'package:niu_app/features/profile/widgets/confirmation_message.dart';
import 'package:niu_app/features/profile/widgets/contact_info.dart';
import 'package:niu_app/features/profile/widgets/phone.dart';
import 'package:niu_app/features/profile/widgets/user_icon.dart';
import 'package:niu_app/features/profile/widgets/username.dart';
import 'package:niu_app/features/profile/widgets/zip.dart';
import '../../../config/const.dart';
import '../../../shared/repositories/shared_preferences.dart';
import '../../auth/screens/authentication_screen.dart';
import '../../global position /screens/global_position_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  const ProfileScreen({
    super.key,
    required this.email,
    required this.toggleTheme,
    required this.isDarkTheme,
  });

  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final repository = SharedPreferencesRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  bool isLoading = true;
  String message = '';
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await repository.readUser(widget.email);
    if (userData != null) {
      emailController.text = userData['email'] ?? '';
      userController.text = userData['user'] ?? '';
      phoneController.text = userData['phone'] ?? '';
      addressController.text = userData['address'] ?? '';
      zipController.text = userData['zip'] ?? '';
      cityController.text = userData['city'] ?? '';
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _updateUserData() async {
    final success = await repository.updateUser(
      widget.email,
      user: userController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      zip: zipController.text.trim(),
      city: cityController.text.trim(),
    );
    setState(() {
      message = success ? 'Data updated.' : 'Error data update.';
    });
  }

  void _onItemTapped(int index) {
    if (index == currentIndex) return;
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GlobalPositionScreen(
            email: widget.email,
            toggleTheme: widget.toggleTheme,
            isDarkTheme: widget.isDarkTheme,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'toggleTheme') {
                widget.toggleTheme();
                setState(() {});
              } else if (value == 'logout') {
                loguot();
              } else if (value == 'deleteAccount') {
                deleteAccount();
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'toggleTheme',
                child: Row(
                  children: [
                    Icon(widget.isDarkTheme
                        ? Icons.dark_mode
                        : Icons.light_mode),
                    const SizedBox(width: 8),
                    Text(widget.isDarkTheme ? 'Light Mode' : 'Dark Mode'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'deleteAccount',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const UserIcon(),
                    Center(
                      child: Text(widget.email,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    smallSpace,
                    const ContactInfo(),
                    smallSpace,
                    Username(userController: userController),
                    midSpace,
                    Phone(phoneController: phoneController),
                    midSpace,
                    Address(addressController: addressController),
                    midSpace,
                    Zip(zipController: zipController),
                    midSpace,
                    City(cityController: cityController),
                    midSpace,
                    Center(
                      child: ElevatedButton(
                        onPressed: _updateUserData,
                        child: const Text('Save your data'),
                      ),
                    ),
                    smallSpace,
                    Center(
                      child: ConfirmationMessage(message: message),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
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

  void loguot() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationScreen(
          toggleTheme: widget.toggleTheme,
          isDarkTheme: widget.isDarkTheme,
        ),
      ),
      (route) => false,
    );
  }

  void deleteAccount() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm delete Account'),
            content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                  onPressed: () async {
                    final currentContext = context;
                    await SharedPreferencesRepository()
                        .deleteUser(widget.email);
                    if (currentContext.mounted) {
                      Navigator.of(currentContext).pop();
                      loguot();
                    }
                  },
                  child: const Text(
                    'Confirm Delete',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }
}
