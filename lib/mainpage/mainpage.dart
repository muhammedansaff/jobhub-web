import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobhub_web/login/login_screen.dart';
import 'package:jobhub_web/pages/UserRequests.dart';
import 'package:jobhub_web/pages/add_post.dart';
import 'package:jobhub_web/pages/complaints.dart';
import 'package:jobhub_web/pages/workers.dart';
import '../pages/feedback.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text('Logout'),
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
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _showLogoutConfirmationDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 1.3,
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
                    builder: (context) => const feedbackList(),
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
                    builder: (context) => Complains(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuOption({
  required IconData icon,
  required String text,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.blue,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
