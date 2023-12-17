import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UpdateData {
  Future<String> uploadImagetoStorage(String childname, Uint8List file) async {
    Reference ref = _storage.ref().child(childname);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> savedData(
      { required Uint8List file}) async {
    String resp = "Some Error Occured";
    final auth = FirebaseAuth.instance;


    try{
      if(true) {
        String imageUrl = await uploadImagetoStorage('profileImage', file);
        await _firestore.collection('Profile').doc(FirebaseAuth.instance.currentUser!.uid).update({

          'imageLink': imageUrl,

        });


        resp = 'Success';
      }
    }
    catch(err){
      resp=err.toString();

    }
    return resp;

  }

}
