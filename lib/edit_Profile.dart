import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_craft/resources/update.dart';
import 'package:uni_craft/utils.dart';

class edit_profile extends StatefulWidget {
  var profile_info = [];

  edit_profile(this.profile_info);

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  Uint8List? _image;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  Future<String> uploadImagetoStorage(String childname, Uint8List file) async {
    Reference ref = _storage.ref().child(childname);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox.fromSize(
              size: Size(0, 200),
            ),
            Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 51,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 51,
                          backgroundImage: NetworkImage(widget.profile_info[0]),
                          backgroundColor: Colors.grey,
                        ),
                  Positioned(
                      bottom: -5,
                      right: -7,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
            SizedBox.fromSize(size: Size(0,100),),
            ElevatedButton(onPressed: () async {
              String resp=await UpdateData().savedData(file: _image!);
              Navigator.pop(context);

            }, child: Text("Save Profile"))
          ],
        ));
  }
}
