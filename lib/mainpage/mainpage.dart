import 'package:flutter/material.dart';
import 'package:jobhub_web/login/login_screen.dart';

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
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 300,
                    width: 300,
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 300,
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          MaterialButton(
                            shape: const CircleBorder(
                              side: BorderSide(
                                color: Color(0xFFECE5B6),
                              ),
                            ),
                            splashColor: const Color(0xFFECE5B6),
                            onPressed: () {},
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
                      )),
                ),
                const SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 300,
                    width: 300,
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
