import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class feedbackList extends StatelessWidget {
  const feedbackList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Feedbacks'),
      ),
      body: const FeedbacksList(),
    );
  }
}

class FeedbacksList extends StatelessWidget {
  const FeedbacksList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('feedbacks').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No feedbacks found.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var feedback = snapshot.data!.docs[index];
            var userName = feedback['userName'];
            var userFeedback = feedback['feedback'];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userFeedback),
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  // Add trailing if you want to show additional information
                ),
              ),
            );
          },
        );
      },
    );
  }
}
