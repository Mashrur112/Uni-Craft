import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uni_craft/resources/update.dart';
import 'package:uni_craft/utils.dart';
final formKey = GlobalKey<FormState>();

class edit_profile extends StatefulWidget {
  var profile_info = [];


  edit_profile(this.profile_info, {super.key});

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  Uint8List? _image;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var name = TextEditingController();
  var age = TextEditingController();
  var roll = TextEditingController();
  var email = TextEditingController();
  var del=false;
  var check_for_save=false;

  String dropdownvalue = "Co-Administrator";

  var items = [
    'Co-Administrator',



    'General member',

  ];




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
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").snapshots(), builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                //print(del);
                if(snapshot.hasData && del==true )
                  {
                    final res=snapshot.data?.docs.toList();
                    for(var r in res!)
                      {
                        //print(del);
                        if(r['code']==widget.profile_info[6] && r['role']=="Co-Administrator")
                          {
                            //print(del);
                            FirebaseFirestore.instance.collection('Profile').doc(r['uid']).delete();


                          }
                        if(r['code']==widget.profile_info[6] && r['role']=='General member') {
                          FirebaseFirestore.instance.collection('Profile').doc(r['uid']).delete();
                        }

                      }
                    return const Center();

                  }
                else {
                  return const Center();
                }

              }),






              SizedBox.fromSize(
                size: const Size(0, 200),
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 51,
                    backgroundImage: MemoryImage(_image!),
                  )
                      : CircleAvatar(
                    radius: 51,
                    backgroundImage:
                    CachedNetworkImageProvider(widget.profile_info[0]),
                    backgroundColor: Colors.grey,
                  ),
                  Positioned(
                      bottom: -5,
                      right: -7,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ))),
                ],
              ),
              SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
              widget.profile_info[5]=='Co-Administrator'?
              DropdownButton(

                // Initial Value
                value: dropdownvalue,
                dropdownColor: Colors.black,


                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items,style: const TextStyle(color: Colors.white),),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ):const Center(),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: name,
                        decoration: InputDecoration(
                          hintText: widget.profile_info[1],
                          hintStyle: const TextStyle(color: Colors.white70),
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
                          // label: Text(
                          //   "Name",
                          //   style: TextStyle(color: Colors.white70),
                          // ),
                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            value=widget.profile_info[1];
                          }
                          if (
                              !RegExp(r'[a-zA-Z]').hasMatch(value!)) {
                            return "Enter Your name ";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: widget.profile_info[2],
                          hintStyle: const TextStyle(color: Colors.white70),
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

                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            value=widget.profile_info[2];
                          }
                          if (
                              !RegExp(r'[0-9]').hasMatch(value!)) {
                            return "Enter Your age ";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: email,
                        decoration: InputDecoration(
                          hintText: widget.profile_info[4],
                          hintStyle: const TextStyle(color: Colors.white70),
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

                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            value=widget.profile_info[4];
                          }
                          if (
                              !RegExp(r'[@]*[.]').hasMatch(value!)) {
                            return "Enter Your Email address ";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: roll,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: widget.profile_info[3],
                          hintStyle: const TextStyle(color: Colors.white70),
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

                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            value=widget.profile_info[3];
                          }
                          if (
                              !RegExp(r'[0-9]').hasMatch(value!)) {
                            return "Enter Your roll number ";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox.fromSize(size: Size(0, (31 / 872) * screenH)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () async {
                   if( !formKey.currentState!.validate()){}
                   else {
                     //print(widget.profile_info[1]);


                     if (name.text.toString() != widget.profile_info[1] &&
                         name.text.toString() != '') {
                       FirebaseFirestore.instance.collection('Profile').doc(
                           FirebaseAuth.instance.currentUser!.uid).update(
                           {
                             'name1': name.text.toString(),
                           });
                     }
                     if (age.text.toString() != widget.profile_info[2] &&
                         age.text.toString() != '') {
                       FirebaseFirestore.instance.collection('Profile').doc(
                           FirebaseAuth.instance.currentUser!.uid).update(
                           {
                             'age1': age.text.toString(),
                           });
                     }
                     if (email.text.toString() != widget.profile_info[4] &&
                         email.text.toString() != '') {
                       FirebaseFirestore.instance.collection('Profile').doc(
                           FirebaseAuth.instance.currentUser!.uid).update(
                           {
                             'email': email.text.toString(),
                           });
                     }
                     if (roll.text.toString() != widget.profile_info[3] &&
                         roll.text.toString() != '') {
                       FirebaseFirestore.instance.collection('Profile').doc(
                           FirebaseAuth.instance.currentUser!.uid).update(
                           {
                             'roll': roll.text.toString(),
                           });
                     }
                     if (dropdownvalue != widget.profile_info[5] && widget.profile_info[5]!="Administrator" &&  widget.profile_info[5]!="General member") {
                       FirebaseFirestore.instance.collection('Profile').doc(
                           FirebaseAuth.instance.currentUser!.uid).update(
                           {
                             'role': dropdownvalue,
                           });
                     }


                     if (_image != null) {
                       await UpdateData().savedData(file: _image!);
                     }

                   }


                  }, child: const Text("Save Profile")),
                  SizedBox.fromSize(size: Size((10/392)*screenW, 0),),
                  ElevatedButton(onPressed: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        check_for_save = true;
                      }
                    } on SocketException catch (_) {
                      check_for_save = false;
                    }
                    setState(() {
                      if(widget.profile_info[5]=="Administrator" && check_for_save==true) {
                        del=true;
                      }
                    });
                    if(check_for_save==true)
                      {





                    await FirebaseFirestore.instance.collection('Profile').doc(FirebaseAuth.instance.currentUser!.uid).delete();
                          Navigator.pop(context);}


                  }, child: const Text("Delete Profile"))
                ],
              )
            ],
          ),
        ));
  }
}
