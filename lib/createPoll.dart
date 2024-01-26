import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePoll extends StatefulWidget {
  var uid_admin;
  CreatePoll(this.uid_admin);
  @override
  _CreatePollState createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();

  List<String> options = [];
  List<String> poll_id = [];

  @override
  void dispose() {
    _captionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb8d8d8),
      appBar: AppBar(
        backgroundColor: Color(0xff7a9e9f),
        title: Text('Create Poll'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Caption:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  hintText: 'Enter poll caption',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Options:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildOptionTextField(_option1Controller, 'Option 1'),
              SizedBox(height: 10),
              _buildOptionTextField(_option2Controller, 'Option 2'),
              SizedBox(height: 10),
              _buildOptionTextField(_option3Controller, 'Option 3'),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      options.clear();
                      if (_option1Controller.text.isNotEmpty) {
                        options.add(_option1Controller.text);
                      }
                      if (_option2Controller.text.isNotEmpty) {
                        options.add(_option2Controller.text);
                      }
                      if (_option3Controller.text.isNotEmpty) {
                        options.add(_option3Controller.text);
                      }
                    });
                    _createPoll();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                  ),
                  child: Text('Create Poll'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTextField(
      TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _createPoll() {
    String caption = _captionController.text;
    if (caption.isEmpty || options.length < 2) {
      _showErrorDialog();
    } else {
      // Initialize Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Collection reference
      CollectionReference polls = firestore.collection('Profile');

      // Create a document with an auto-generated ID
      polls.doc(widget.uid_admin).update({
        'caption': caption,
        'options': options,
        'votes': List.filled(options.length, '0'),
        'poll_id': List.filled(0, '0'),
      }).then((value) {
        // Successfully added to Firestore
        print('Poll created with ID: ${widget.uid_admin}');

        // Here, you can navigate to the poll view page or perform other actions
      }).catchError((error) {
        // Error handling
        print('Failed to create poll: $error');
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a caption and at least 2 options.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
