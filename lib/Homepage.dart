import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';



import 'package:uni_craft/resources/data.dart';
import 'package:uni_craft/utils.dart';




final formKey = GlobalKey<FormState>();

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  //final user=FirebaseAuth.instance.currentUser!;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final user=FirebaseAuth.instance.currentUser!;
  var name = TextEditingController();
  var age = TextEditingController();
  var roll = TextEditingController();
  var email = TextEditingController();
  var count = 0;
  var join_code = TextEditingController();
  final currentUser = FirebaseAuth.instance;
  bool check_for_save = false;
  var x = 0;
  var data = 1;
  var y=null;
  int c=0;
  var val_join=false;
  var join_check=false;
  String dropdownvalue = 'Choose a ROLE';
  List token=[];
  var same_dev=false;

  var items = [
    'Choose a ROLE',
    'Administrator',
    'Co-Administrator',
    'General member',
  ];

  Uint8List? _image;

  String email1 = FirebaseAuth.instance.currentUser!.email.toString();

  Future<void> signout() async {
    final GoogleSignIn googleSign = GoogleSignIn();
    await googleSign.signOut();
    FirebaseAuth.instance.signOut();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() {}

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
        backgroundColor: const Color(0xffb8d8d8),
        appBar: AppBar(
          backgroundColor:const Color(0xffb8d8d8),
          actions: [
            IconButton(
                onPressed: () {
                  signout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 0,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("userProfile")
                      .where('uid', isEqualTo: currentUser.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasData){
                    data = 1;

                    data = snapshot.data!.docs.length;}
                    return const Text("Null");

                    //data1=snapshot.data!.docs[0]['uid'];

                    // if (snapshot.hasData) {
                    //   return Text("SUCCESS");
                    // } else {
                    //   //check_for_save = false;
                    //   return Text("failed");
                    // }
                  },
                ),
              ),
              SizedBox.fromSize(size: Size(0, (15 / 872) * screenH)),
              const Text(
                "Set up your profile!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
              SizedBox.fromSize(size: const Size(0, 21 / 872) * screenH),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 51,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 51,
                          backgroundImage:
                              AssetImage("assets/images/profile.png"),
                          backgroundColor:  Color(0xff1b6e70),
                        ),
                  Positioned(
                      bottom: -5,
                      right: -7,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color:  Color(0xffe0feff),
                          ))),
                ],
              ),
              SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
              DropdownButton(
                // Initial Value
                value: dropdownvalue,
                dropdownColor: const Color(0xffb7eced),
                borderRadius: BorderRadius.circular(12),

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: name,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                                color:  Color(0xff4f6367),
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(1),

                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff4f6367),
                              )),
                          label: const Text(
                            "Name",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'[a-zA-Z]').hasMatch(value)) {
                            return "Enter Your name ";
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                                color:  Color(0xff4f6367),
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                              borderSide: const BorderSide(
                                width: 2,
                                color:  Color(0xff4f6367),
                              )),
                          label: const Text("Age: ",
                              style: TextStyle(color: Colors.black)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'[0-9]').hasMatch(value)) {
                            return "Enter Your age ";
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: email,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                                color:  Color(0xff4f6367),
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                              borderSide: const BorderSide(
                                width: 2,
                                color:  Color(0xff4f6367),
                              )),
                          label: const Text("Enter your Email address",
                              style: TextStyle(color: Colors.black)),
                          hintText: email1,
                          hintStyle:
                          const TextStyle(color: Colors.black26, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'[@]*[.]').hasMatch(value)) {
                            return "Enter Your Email address ";
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: (10 / 372) * screenW),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: roll,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                                color:  Color(0xff4f6367),
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                              borderSide: const BorderSide(
                                width: 2,
                                color:  Color(0xff4f6367),
                              )),
                          label: const Text("Roll Number",
                              style: TextStyle(color: Colors.black)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'[0-9]').hasMatch(value)) {
                            return "Enter Your roll number ";
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                    dropdownvalue == "Administrator"
                        ? Container(
                            height: (50 / 872) * screenH,
                            child: x != 0
                                ? Text(
                                    "Join code:" + x.toString(),
                                    style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 19),
                                  )
                                : Text("Please Generate Code",
                                    style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 19),
                            )
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: (10 / 372) * screenW),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: join_code,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color:   Color(0xff4f6367),
                                    )),
                                enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(1),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color:  Color(0xff4f6367),
                                    )),
                                label: const Text("joining code",
                                    style: TextStyle(color: Colors.black)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Your joining code  ";
                                } else
                                  return null;
                              },
                            ),
                          ),
                   // SizedBox.fromSize(size:Size(0,0.05*screenH)),
                  ],
                ),
              ),


              dropdownvalue != 'Administrator'
                  ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Profile')

                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> snapshot) {





                    if(snapshot.hasData)
                    {
                      c=0;
                      final res=snapshot.data?.docs.toList();



                      for(var r in res!) {
                        c++;
                        if(r['code']==join_code.text)
                          {
                            try{
                              token.add(r['token']);

                            }catch(e){};
                          }


                        if(r['code']==join_code.text && r['role']=="Administrator")
                          {
                            val_join=true;
                            y=snapshot.data!.docs[c-1]['code'];

                          break;}
                        else
                          {
                            val_join=false;
                          }





                      }
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Authpage2()));
                     // print(c);
                      return const Center();


                    }
                    else
                    {

                      return const Center();
                    }

                  })
                  : const Center(),
              //SizedBox.fromSize(size: Size(0, (5 / 872) * screenH)),
              dropdownvalue == "Administrator"
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:  const Color(0xff35797a),
                          elevation: 6,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),

                          onPressed: () {
                            setState(() {
                              if (x == 0) x = UniqueKey().hashCode;
                            });


                          },
                          child:const Text("Generate Code",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: 18),)),
                     SizedBox.fromSize(size: Size(0.06*screenW,0),),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:  const Color(0xff35797a),
                              elevation: 6,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () async {
                            // setState(() {
                            //
                            //
                            // });
                            formKey.currentState!.validate();


                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         title: Text(
                            //           "sdfsdf",
                            //         ),
                            //       );
                            //     });
                            // Navigator.pop(context);
                            // Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()) );

                            try {
                              final result = await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                check_for_save = true;
                              }
                            } on SocketException catch (_) {
                              check_for_save = false;
                            }








//print (data);
                            //print (data1);
                            if (data == 0 && check_for_save && formKey.currentState!.validate()) {


                              if (x == 0 && dropdownvalue == 'Administrator') {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        elevation: 51,
                                        shadowColor: Colors.black26,
                                        icon:  Icon(Icons.warning_amber),
                                        iconColor:  Color(0xffff8080),
                                        backgroundColor:   Color(0xff35797a),
                                        title:  Text(
                                          "Please Generate a Code",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    });
                              }
                              else if(val_join==false && dropdownvalue!="Administrator")
                              {

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        elevation: 51,
                                        shadowColor: Colors.black26,
                                        icon: Icon(Icons.warning_amber),
                                        iconColor: Color(0xffff8080),
                                        backgroundColor:  Color(0xff35797a),
                                        title: Text(
                                          "Wrong joining code, Try again",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    });





                              }

                              else if (_image == null) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        elevation: 51,
                                        shadowColor: Colors.black26,
                                        icon: Icon(Icons.warning_amber),
                                        iconColor: Color(0xffff8080),
                                        backgroundColor:  Color(0xff35797a),
                                        title: Text(
                                          "Add an Image",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    });
                              } else {
                                if (dropdownvalue == 'Choose a ROLE') {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          elevation: 51,
                                          shadowColor: Colors.black26,
                                          icon:  Icon(Icons.warning_amber),
                                          iconColor:  Color(0xffff8080),
                                          backgroundColor:   Color(0xff35797a),
                                          title:  Text(
                                            "Please select a role",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        );
                                      });
                                } else {


                                  var name1 = name.text;
                                  var age1 = age.text;
                                  var roll1 = roll.text;
                                  var email1 = email.text;


                                  if(dropdownvalue=='Administrator'){
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    );






                                      StoreData().savedData(

                                      name: name1,
                                      age: age1,
                                      file: _image!,
                                      roll: roll1,
                                      email: email1,
                                      role: dropdownvalue,
                                      token: "",

                                      code: x,
                                    );
                                    await  Future.delayed(Duration(milliseconds: 2000));
                                    Navigator.of(context).pop();

                                    FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                      '0':"",
                                      '1':"",
                                    });

                                  }
                                  else{
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    );




                                    var token1=FirebaseMessaging.instance.getToken().toString();

                                     StoreData().savedData(

                                      name: name1,
                                      age: age1,
                                      file: _image!,
                                      roll: roll1,
                                      email: email1,
                                      role: dropdownvalue,
                                      token: token1,

                                      code: y,
                                    );
                                    await  Future.delayed(Duration(milliseconds: 2000));
                                    Navigator.of(context).pop();

                                  }


                                }
                              }
                            }
                          },
                          child: const Text(
                            "Save Profile",
                            style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: 19),
                          )),

                    ],
                  )
                  :

              Padding(
                padding:  EdgeInsets.symmetric(vertical: 0.05*screenH),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  const Color(0xff35797a),
                        elevation: 6,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () async {
                      // setState(() {
                      //
                      //
                      // });
                      formKey.currentState!.validate();





                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: Text(
                      //           "sdfsdf",
                      //         ),
                      //       );
                      //     });
                      // Navigator.pop(context);
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()) );

                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          check_for_save = true;
                        }
                      } on SocketException catch (_) {
                        check_for_save = false;
                      }








                //print (data);
                      //print (data1);
                      if (data == 0 && check_for_save && formKey.currentState!.validate()) {


                        if (x == 0 && dropdownvalue == 'Administrator') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  elevation: 51,
                                  shadowColor: Colors.black26,
                                  icon:  Icon(Icons.warning_amber),
                                  iconColor:  Color(0xffff8080),
                                  backgroundColor:   Color(0xff35797a),
                                  title:  Text(
                                    "Please Generate a Code",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              });
                        }
                        else if(val_join==false && dropdownvalue!="Administrator")
                          {

                          showDialog(
                          context: context,
                          builder: (context) {
                          return const AlertDialog(
                          elevation: 51,
                          shadowColor: Colors.black26,
                          icon:  Icon(Icons.warning_amber),
                            iconColor:  Color(0xffff8080),
                            backgroundColor:   Color(0xff35797a),
                          title:  Text(
                          "Wrong joining code, Try again",
                          style: TextStyle(color: Colors.white),
                          ),
                          );
                          });





                          }

                        else if (_image == null) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  elevation: 51,
                                  shadowColor: Colors.black26,
                                  icon:  Icon(Icons.warning_amber),
                                  iconColor:  Color(0xffff8080),
                                  backgroundColor:   Color(0xff35797a),
                                  title:  Text(
                                    "Add an Image",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              });
                        } else {
                          if (dropdownvalue == 'Choose a ROLE') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    elevation: 51,
                                    shadowColor: Colors.black26,
                                    icon:  Icon(Icons.warning_amber),
                                    iconColor:  Color(0xffff8080),
                                    backgroundColor:   Color(0xff35797a),
                                    title:  Text(
                                      "Please select a role",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                });
                          } else {


                            var name1 = name.text;
                            var age1 = age.text;
                            var roll1 = roll.text;
                            var email1 = email.text;


                            if(dropdownvalue=='Administrator'){


                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              );




                              StoreData().savedData(

                              name: name1,
                              age: age1,
                              file: _image!,
                              roll: roll1,
                              email: email1,
                              role: dropdownvalue,
                              token: "",

                              code: x,
                            );
                              await  Future.delayed(Duration(milliseconds: 2000));
                              Navigator.of(context).pop();
                            FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                              '0':"",
                              '1':"",
                            });

                            }
                            else{

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              );

                              final token1= await FirebaseMessaging.instance.getToken();
                                StoreData().savedData(

                                name: name1,
                                age: age1,
                                file: _image!,


                                roll: roll1,
                                email: email1,
                                role: dropdownvalue,
                                token: token1.toString(),

                                code: y,
                              );
                              await  Future.delayed(Duration(milliseconds: 2000));
                              Navigator.of(context).pop();

                            }

                          }
                        }
                      }



                    },
                    child: const Text(
                      "Save Profile",
                      style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ],
          ),
        ));
  }
}
