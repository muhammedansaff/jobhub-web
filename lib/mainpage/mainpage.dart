import 'package:flutter/material.dart';

// Import authentication library
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobhub_web/login/login_screen.dart';
import 'package:jobhub_web/pages/UserRequests.dart';

import 'package:jobhub_web/pages/add_post.dart';
import 'package:jobhub_web/pages/complaints.dart';
import 'package:jobhub_web/pages/workers.dart';
import '../pages/feedback.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Initialize FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle logout
  Future<void> _logout() async {
    await _auth.signOut();
    // Navigate to login page
    // You need to define your login page route here
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  // Function to show logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                _logout(); // Call logout function
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFECE5B6),
        appBar: AppBar(
          title: const Text('Admin Page'),
          leading: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserRequests()),
              );
            },
          ),
          actions: [
            // Logout IconButton
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _showLogoutConfirmationDialog,
            ),
            // Button to navigate to UserRequests page
          ],
        ),
        body: Center(
          child: Container(
            width: 1980,
            height: 1000,
            child: Card(
              color: Colors.black45,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMenuOption(
                      icon: Icons.contacts,
                      text: "Workers",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkersList(),
                          ),
                        );
                      },
                    ),
                    _buildMenuOption(
                      icon: Icons.feed_rounded,
                      text: "Feedbacks",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComplaintsList(),
                          ),
                        );
                      },
                    ),
                    _buildMenuOption(
                      icon: Icons.add,
                      text: "Add Post",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPosts(),
                          ),
                        );
                      },
                    ),
                    _buildMenuOption(
                      icon: Icons.error,
                      text: "Complaints",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbacksPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Widget _buildMenuOption(
    {required IconData icon,
    required String text,
    required VoidCallback onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 300,
      height: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFECE5B6), Colors.blue],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
