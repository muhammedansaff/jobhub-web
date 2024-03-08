import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobhub_web/Services/global_methods.dart';

class UserView extends StatefulWidget {
  final String userName;
  final String email;
  final String uid;
  final String userImage;
  final String phoneNumber;
  final String location;

  const UserView(
      {super.key,
      required this.email,
      required this.uid,
      required this.userName,
      required this.location,
      required this.userImage,
      required this.phoneNumber});

  @override
  State<UserView> createState() => _UserViewState();
}

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
                      .collection('users')
                      .doc(widget.uid)
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
              Text('Location:${widget.location}'),
              Text('Phone Number: ${widget.phoneNumber}'),
              Text('Phone Number: ${widget.uid}'),
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
          onTap: () {
            _showUserDetailsDialog();
          },
          onLongPress: () {
            _deleteDialog();
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
          title: Column(
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
          subtitle: Text(
            widget.location,
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
