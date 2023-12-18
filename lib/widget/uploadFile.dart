import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../api/firebase_api.dart';
import 'button_widget.dart';

class uploadFile extends StatefulWidget {
  @override
  State<uploadFile> createState() => _uploadFileState();
}

class _uploadFileState extends State<uploadFile> {
  var urlDownload;
  UploadTask? task;
  File? file;
  var upload_check = false;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 0,
            width: 0,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Profile")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && upload_check == true) {
                    final res = snapshot.data!.docs.toList();
                    for (var r in res!) {
                      if (r['uid'] == FirebaseAuth.instance.currentUser!.uid &&
                          r['role'] == "Administrator") {
                        int c = 0;
                        int b = c + 1;
                        while (true) {
                          try {
                            if (r[c.toString()] == "") {
                              break;
                            } else {
                              c = c + 2;
                              b = c + 1;
                            }
                          } catch (e) {
                            break;
                          }
                        }

                        FirebaseFirestore.instance
                            .collection("Profile")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          c.toString(): urlDownload.toString(),
                          b.toString(): fileName.toString(),
                        });
                        upload_check = false;
                      }
                    }
                    return Text("Upload Successfull");
                  } else
                    return Container();
                }),
          ),
          SizedBox.fromSize(size: Size(0, (((300 / 872) * screenH)))),
          Container(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    text: 'Select File',
                    icon: Icons.attach_file,
                    onClicked: selectFile,
                  ),
                  SizedBox(height: 8),
                  Text(
                    fileName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 48),
                  ButtonWidget(
                    text: 'Upload File',
                    icon: Icons.cloud_upload_outlined,
                    onClicked: uploadFile,
                  ),
                  SizedBox(height: 20),
                  task != null ? buildUploadStatus(task!) : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
    upload_check = false;
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      upload_check = true;
    });

   // print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
