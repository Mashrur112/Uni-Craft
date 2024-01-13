import'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String messege;
  const ChatBubble({super.key, required this.messege});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: Text(
        messege,
        style:
        const TextStyle(fontSize: 16),
      ),
    );
  }
}
