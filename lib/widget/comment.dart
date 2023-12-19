import 'package:flutter/material.dart';
import 'package:tugas_uas/screen/comment_page.dart';

class CommentButton extends StatefulWidget {
  // final int id;

  const CommentButton({super.key});

  @override
  _CommentButtonState createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CommentPage()),
            );
          },
          icon: const Icon(Icons.comment), // Replace with the desired icon
          label: const Text('Add Comment'),
        ),
      ],
    );
  }
}
