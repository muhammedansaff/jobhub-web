import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobhub_web/widget/userView.dart';

class WorkersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workers'),
      ),
      body: const WorkersListView(),
    );
  }
}

class WorkersListView extends StatelessWidget {
  const WorkersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('workers')
          .where('status', isEqualTo: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          // ignore: avoid_print
          print('Error fetching data: ${snapshot.error}');
          return const Center(child: Text('Error fetching data'));
        }

        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No new requests'));
        }

        // ignore: avoid_print
        print('Data count: ${snapshot.data!.docs.length}');
        // ignore: avoid_print

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final userDoc = snapshot.data!.docs[index];
            final phone = userDoc['phoneNumber'];
            final emaill = userDoc['email'];
            final profession = userDoc['profession'];
            final uid = userDoc['id'];
            final idimg = userDoc['myId'];
            final name = userDoc['name'];
            final userImage = userDoc['userImage'];
            final pass = userDoc['password'];
            return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 4), // Add vertical spacing here
                child: UserView(
                    pass: pass,
                    check: false,
                    img: idimg,
                    phoneNumber: phone,
                    email: emaill,
                    uid: uid,
                    prof: profession,
                    userName: name,
                    userImage: userImage));
          },
        );
      },
    ); //code for filtered list builder
  }
}
