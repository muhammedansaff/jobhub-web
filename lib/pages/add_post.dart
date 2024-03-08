import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:uuid/uuid.dart';

//import 'dart:io';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddPostsState createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  String? imageUrl;

  String? posturl;

  uploadToStorage() {
    FirebaseStorage fs = FirebaseStorage.instance;
    InputElement input =
        (FileUploadInputElement()..accept = 'image/*') as InputElement;
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;

      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        String pid = const Uuid().v4();
        var snapshot = await fs.ref('post').child('$pid.jpg').putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        FirebaseFirestore.instance.collection('posts').doc(pid).set({
          'postid': pid,
          'posturl': downloadUrl,
          'postedtime': Timestamp.now()
        });

        setState(() {
          imageUrl = downloadUrl;
          print('img:${imageUrl}');
        });
      });
    });
    Fluttertoast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: imageUrl == null
            ? const Text('No image selected.')
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: uploadToStorage,
            tooltip: 'Upload Image',
            child: const Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }
}
