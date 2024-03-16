import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobhub_web/Services/global_methods.dart';

class UserView extends StatefulWidget {
  final String userName;
  final String email;
  final String uid;
  final String userImage;
  final String phoneNumber;
  final String prof;
  final String img;
  final bool check;
  final String pass;
  const UserView(
      {super.key,
      required this.pass,
      required this.check,
      required this.img,
      required this.prof,
      required this.email,
      required this.uid,
      required this.userName,
      required this.userImage,
      required this.phoneNumber});

  @override
  State<UserView> createState() => _UserViewState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _UserViewState extends State<UserView> {
  _deleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete user'),
          content: Text(
            'do you want to delete the user ${widget.userName}?',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  // Delete the job document

                  await FirebaseFirestore.instance
                      .collection('workers')
                      .doc(widget.email.toString())
                      .delete();

                  // Delete the 'applied' collection

                  await Fluttertoast.showToast(
                    msg: '${widget.userName} deleted',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.grey,
                    fontSize: 18,
                    gravity: ToastGravity.CENTER,
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                } catch (error) {
                  // ignore: use_build_context_synchronously
                  GlobalMethod.showErrorDialog(
                    error: 'This task cannot be deleted',
                    ctx: context,
                  );
                }
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showUserDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.userName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Email: ${widget.email}'),
              Text('Phone Number: ${widget.phoneNumber}'),
              Text('profession: ${widget.prof}'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Image'),
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.5, // Adjust the width as needed
                                  height: MediaQuery.of(context).size.height *
                                      0.5, // Adjust the height as needed
                                  child: Image.network(widget.img.toString()),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.image)),
                  ),
                  Text("${widget.userName}'s ID")
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _updateStatus() async {
    try {
      // Create user in Firebase Authentication
      await _auth.createUserWithEmailAndPassword(
          email: widget.email.trim().toLowerCase(),
          password: widget.pass.trim());

      // Update the status field for the document with the specified ID
      await FirebaseFirestore.instance
          .collection('workers')
          .doc(widget.email)
          .update({'status': true});

      Fluttertoast.showToast(
        msg: 'Status updated successfully',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.grey,
        fontSize: 18,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      GlobalMethod.showErrorDialog(
        error: 'Failed to update status: $error',
        ctx: context,
      );
    }
  }

  void _deleteUser() async {
    try {
      // Delete user from Firebase Authentication
      await _auth.signInWithEmailAndPassword(
          email: widget.email.trim().toLowerCase(),
          password: widget.pass.trim());
      var user = _auth.currentUser;
      await user!.delete();

      // Delete the user document from Firestore
      await FirebaseFirestore.instance
          .collection('workers')
          .doc(widget.email)
          .delete();

      Fluttertoast.showToast(
        msg: 'User deleted successfully',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.grey,
        fontSize: 18,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      GlobalMethod.showErrorDialog(
        error: 'Failed to delete user: $error',
        ctx: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        color: Colors.black54,
        shadowColor: const Color.fromARGB(25, 216, 230, 110),
        elevation: 15,
        child: ListTile(
          onLongPress: () {
            _deleteDialog();
          },
          onTap: () {
            _showUserDetailsDialog();
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: const Color(0xFFECE5B6),
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(widget.userImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFFECE5B6),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4), // Decreased vertical space here
                    Text(
                      widget.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              widget.check
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                _updateStatus();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteUser();
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          ),
          subtitle: Text(
            widget.prof,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
