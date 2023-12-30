import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'viewPollResult.dart';

class ViewPoll extends StatefulWidget {
  final String pollId;

  const ViewPoll({Key? key, required this.pollId}) : super(key: key);

  @override
  _ViewPollState createState() => _ViewPollState();
}

class _ViewPollState extends State<ViewPoll> {
  late String _pollId;
  late String _caption;
  late List<dynamic> _options;
  late List<dynamic> _votes;

  @override
  void initState() {
    super.initState();
    _pollId = widget.pollId;
    _loadPollData();
  }

  Future<void> _loadPollData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot pollSnapshot = await firestore.collection('polls').doc(_pollId).get();

    setState(() {
      _caption = pollSnapshot['caption'];
      _options = List.from(pollSnapshot['options']);
      _votes = List.from(pollSnapshot['votes']);
    });
  }

  Future<void> _vote(int optionIndex) async {
    if (optionIndex >= 0 && optionIndex < _options.length) {
      setState(() {
        _votes[optionIndex] = _votes[optionIndex] + 1;
      });

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('polls').doc(_pollId).update({'votes': _votes});

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewPollResults(pollId: _pollId)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Poll'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$_caption',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _options.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => _vote(index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline),
                        SizedBox(width: 10),
                        Text('${_options[index]}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
