import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internir/screens/authentication/login_screen.dart';
import 'package:internir/utils/app_color.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        iconTheme: const IconThemeData(size: 30, color: AppColor.black),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        color: AppColor.background,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            //---- NOTIFICATION TOGGLE WITH ICON ----\\
            ListTile(
              leading: const Icon(
                Icons.notifications_none,
                size: 30,
                color: AppColor.mainBlue,
              ),
              title: const Text(
                'Enable Notifications',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: AppColor.mainBlue,
                inactiveThumbColor: AppColor.indigo,
              ),
            ),
            const Divider(),

            //---- CHANGE PASSWORD ----\\
            ListTile(
              leading: const Icon(Icons.lock_outline,
                  size: 30, color: AppColor.mainBlue),
              title: const Text(
                'Change Password',
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showChangePasswordDialog();
              },
            ),
            const Divider(),

            //---- DELETE ACCOUNT ----\\
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  size: 30, color: AppColor.red),
              title: const Text('Delete Account',
                  style: TextStyle(color: AppColor.red, fontSize: 18)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showDeleteAccountDialog();
              },
            ),
            const Divider(),

            //---- ABOUT APP ----\\
            ListTile(
              leading: const Icon(Icons.brightness_4_outlined,
                  size: 30, color: AppColor.mainBlue),
              title: const Text(
                'System Mode',
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  //---- SHOW CHANGE PASSWORD DIALOG ----\\
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: const Text(
              'A password reset email has been sent to your email address. Follow the instructions to reset your password.'),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  // Get the current user
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    // Send the password reset email to the user
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: user.email!);

                    // Notify the user that the email has been sent
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password reset email sent.'),
                      ),
                    );

                    // Sign out the user after sending the email
                    await FirebaseAuth.instance.signOut();

                    // Navigate to the login screen and clear the previous routes
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                          (Route<dynamic> route) =>
                      false, // This removes all previous routes
                    );
                  }
                } catch (e) {
                  print('Error sending password reset email: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                      Text('Failed to send reset email. Please try again.'),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  //---- SHOW DELETE ACCOUNT CONFIRMATION ----\\
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
              'Are you sure you want to delete your account? This action is irreversible.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Get the current user
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    // Delete the user data from Firestore
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .delete();

                    // Delete the user account from Firebase Authentication
                    await user.delete();

                    // Navigate back to the Create Account Screen
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Account deleted successfully')),
                    );

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }
                } catch (e) {
                  print('Error deleting account: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Failed to delete account. Please try again.')),
                  );
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

