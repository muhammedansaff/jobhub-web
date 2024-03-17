import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? jobID;

class Complains extends StatelessWidget {
  const Complains({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User complaints'),
        ),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('complaints').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No complaints found.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var complain = snapshot.data!.docs[index];
                var userName = complain['complaining about'];
                var userFeedback = complain['number of people complained'];
                var imgurl = complain['userImage'];
                var rating = complain['rating'];
                var profession = complain['profession'];
                var uid = complain['userId'];
                jobID = complain['jobId'];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete User'),
                              content: Text(
                                  'Are you sure you want to delete $userName?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteUserData(uid);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profession,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "Number of Complaints: ${userFeedback.toString()}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(imgurl),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(width: 2, color: Colors.black),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          return _buildStar(index, rating.toDouble());
                        }),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

Widget _buildStar(int index, double rating) {
  IconData iconData = Icons.star_border;
  Color color = Colors.grey;

  if (index < rating) {
    iconData = Icons.star;
    color = Colors.amber;
  }

  return Icon(
    iconData,
    color: color,
  );
}

void deleteUserData(String userId) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Check if the current user's uid matches the userId provided
      if (user.uid == userId) {
        await user.delete();
        print('User deleted successfully.');
      } else {
        print('User with provided ID not found.');
      }
    } else {
      print('No user signed in.');
    }
  } catch (e) {
    print('Error deleting user: $e');
  }

  await FirebaseFirestore.instance
      .collection('acceptedworkers')
      .where('id', isEqualTo: userId)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  });
  await FirebaseFirestore.instance
      .collection('jobs')
      .doc(jobID)
      .collection('appliedusers')
      .doc(userId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      documentSnapshot.reference.delete();
    }
  });

  await FirebaseFirestore.instance
      .collection('complaints')
      .doc(userId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      documentSnapshot.reference.delete();
    }
  });
  Fluttertoast.showToast(msg: "User deleted successfully");
}
