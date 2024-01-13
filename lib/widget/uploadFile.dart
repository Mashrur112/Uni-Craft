import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../Homepage.dart';
import '../api/firebase_api.dart';
import 'button_widget.dart';

class uploadFile extends StatefulWidget {
  const uploadFile({super.key});

  @override
  State<uploadFile> createState() => _uploadFileState();
}

class _uploadFileState extends State<uploadFile> {
  var urlDownload;
  UploadTask? task;
  File? file;
  var upload_check = false,link_up=false;
  var caption = TextEditingController();
  var link = TextEditingController();
  var check_for_save=false;


  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 0,
              width: 0,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Profile")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData && upload_check == true) {
                      final res = snapshot.data!.docs.toList();
                      for (var r in res) {
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
                      return const Text("Upload Successfull");
                    }
                    if (snapshot.hasData && link_up == true) {
                      final res = snapshot.data!.docs.toList();
                      for (var r in res) {
                        if (r['uid'] == FirebaseAuth.instance.currentUser!.uid &&
                            r['role'] == "Administrator") {
                          int l = 0;
                          int l1 = l + 1;
                          while (true) {
                            try {
                              if (r['link$l'] == "") {
                                break;
                              } else {
                                l = l + 2;
                                l1 = l + 1;
                              }
                            } catch (e) {
                              break;
                            }
                          }

                          FirebaseFirestore.instance
                              .collection("Profile")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                           'link$l': caption.text.toString(),
                            'link$l1': link.text.toString(),
                          });
                          link_up = false;
                        }
                      }
                      return const Text("Upload Successfull");
                    }

                    else {
                      return Container();
                    }
                  }),
            ),
            SizedBox.fromSize(size: Size(0, (((150 / 872) * screenH)))),
            Container(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      text: 'Select File',
                      icon: Icons.attach_file,
                      onClicked: selectFile,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      fileName,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 48),
                    ButtonWidget(
                      text: 'Upload File',
                      icon: Icons.cloud_upload_outlined,
                      onClicked: uploadFile,
                    ),
                    const SizedBox(height: 20),
                    task != null ? buildUploadStatus(task!) : Container(),
                    SizedBox.fromSize(size: Size(0, (41 / 872) * screenH)),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: (10 / 372) * screenW),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: caption,

                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: Colors.white70,
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(1),
                                      borderSide: const BorderSide(
                                        color: Colors.white70,
                                      )),
                                  label: const Text("Caption",
                                      style: TextStyle(color: Colors.white70)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter any caption ";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox.fromSize(
                                size: Size(0, (41 / 872) * screenH)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: (10 / 372) * screenW),
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: link,

                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: Colors.white70,
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(1),
                                      borderSide: const BorderSide(
                                        color: Colors.white70,
                                      )),
                                  label: const Text("Link",
                                      style: TextStyle(color: Colors.white70)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||  !RegExp(r'[h]*[t]*[t]*[p]*[s]*[:]*[/]*[.]*(https://)').hasMatch(value)) {
                                    return "Enter link ";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () async {
                          formKey.currentState!.validate();
                          try {
                            final result = await InternetAddress.lookup('google.com');
                            if (result.isNotEmpty &&
                                result[0].rawAddress.isNotEmpty) {
                              check_for_save = true;
                            }
                          } on SocketException catch (_) {
                            check_for_save = false;
                          }
                          if(check_for_save==true){
                          setState(() {
                            link_up=true;
                          });}
                        },
                        child: const Text(
                          "Upload link",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            );
          } else {
            return Container();
          }
        },
      );
}
