import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_page.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _HomePageState();
}

class _HomePageState extends State<ChatHome> {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Home')),
        ),
      body: _buildUserList(),
    );
  }
  //build a list of users except for the current logged in user
  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots()
        , builder: (context, snapshot){
      if(snapshot.hasError){
        return const Text('error');
      }

      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text('loading...');
      }

      return ListView(
        children:
        snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc))
            .toList(),

      );
    });
  }

  //build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    //display all users except current user
    if(data != null && _auth.currentUser!.email != data['email']){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          //pass the clicked user's UID
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),),);
        },
      );
    }
    else{
      return Container();
    }
  }
}
