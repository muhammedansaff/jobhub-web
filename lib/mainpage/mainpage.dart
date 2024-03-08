import 'package:flutter/material.dart';

import 'package:jobhub_web/pages/add_post.dart';
import 'package:jobhub_web/pages/complaints.dart';
import 'package:jobhub_web/pages/users.dart';

//import 'dart:io';

import '../pages/feedback.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5B6),
      body: Card(
        color: Colors.black45,
        child: Center(
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView to enable scrolling
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border:
                          Border.all(width: 2, color: const Color(0xFFECE5B6)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 300,
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        MaterialButton(
                          minWidth: 100,
                          height: 100,
                          elevation: 5,
                          shape: const CircleBorder(
                            side: BorderSide(
                              width: 3,
                              color: Color(0xFFECE5B6),
                            ),
                          ),
                          splashColor: const Color(0xFFECE5B6),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsersList(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.contacts,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Users",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border:
                          Border.all(width: 2, color: const Color(0xFFECE5B6)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 300,
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        MaterialButton(
                          minWidth: 100,
                          height: 100,
                          elevation: 5,
                          shape: const CircleBorder(
                            side: BorderSide(
                              width: 3,
                              color: Color(0xFFECE5B6),
                            ),
                          ),
                          splashColor: const Color(0xFFECE5B6),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ComplaintsList(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.feed_rounded,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Feedbacks",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border:
                          Border.all(width: 3, color: const Color(0xFFECE5B6)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 300,
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        MaterialButton(
                          minWidth: 100,
                          height: 100,
                          elevation: 5,
                          shape: const CircleBorder(
                            side: BorderSide(
                              width: 3,
                              color: Color(0xFFECE5B6),
                            ),
                          ),
                          splashColor: const Color(0xFFECE5B6),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPosts(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Add Post",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border:
                          Border.all(width: 2, color: const Color(0xFFECE5B6)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 300,
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        MaterialButton(
                          minWidth: 100,
                          height: 100,
                          elevation: 5,
                          shape: const CircleBorder(
                            side: BorderSide(
                              width: 3,
                              color: Color(0xFFECE5B6),
                            ),
                          ),
                          splashColor: const Color(0xFFECE5B6),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbacksPage(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.error,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "complaints",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
