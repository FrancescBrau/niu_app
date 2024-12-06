import 'package:flutter/material.dart';
import 'package:niu_app/config/const.dart';
import 'package:niu_app/shared/repositories/shared_preferences.dart';

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
    );
    setState(() {
      message = success ? 'Data updated.' : 'Error data update.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: widget.toggleTheme,
                icon: Icon(
                    widget.isDarkTheme ? Icons.dark_mode : Icons.light_mode))
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
                        const Center(child: Icon(Icons.person, size: 50)),
                        midSpace,
                        Center(
                          child: Text(emailController.text,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        midSpace,
                        const Text(
                          'Contact Info',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        midSpace,
                        TextFormField(
                          controller: emailController,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        midSpace,
                        TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        midSpace,
                        TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                              labelText: 'Address',
                              prefixIcon: Icon(Icons.mail)),
                        ),
                        midSpace,
                        TextFormField(
                            controller: zipController,
                            decoration: const InputDecoration(
                                labelText: 'ZIP',
                                prefixIcon: Icon(Icons.location_on)),
                            keyboardType: TextInputType.text),
                        midSpace,
                        TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                              labelText: 'City',
                              prefixIcon: Icon(Icons.location_city)),
                          keyboardType: TextInputType.text,
                        ),
                        midSpace,
                        Center(
                          child: ElevatedButton(
                            onPressed: _updateUserData,
                            child: const Text('Save your data'),
                          ),
                        ),
                        smallSpace,
                        Center(
                          child: Text(
                            message,
                            style: const TextStyle(color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
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
        ));
  }
}
