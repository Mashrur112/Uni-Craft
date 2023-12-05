import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImagetoStorage(String childname, Uint8List file) async {
    Reference ref = _storage.ref().child(childname);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> savedData(
      {required var name,required var roll,required var email , required var age, required Uint8List file}) async {
    String resp = "Some Error Occured";

    try{
      if(name.isNotEmpty || age.isNotEmpty || roll.isNotEmpty || email.isNotEmpty) {
        String imageUrl = await uploadImagetoStorage('profileImage', file);
        await _firestore.collection('userProfile').add({
          'name1': name,
          'age1': age,
          'roll':roll,
          'email': email,
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
