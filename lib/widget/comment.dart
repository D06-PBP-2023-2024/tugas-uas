import 'package:flutter/material.dart';
import 'package:tugas_uas/screen/comment_page.dart';

class CommentButton extends StatefulWidget {
  final int id;

  const CommentButton({Key? key, required this.id}) : super(key: key);

  @override
  CommentButtonState createState() => CommentButtonState();
}

class CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommentPage(id: widget.id)),
            );
          },
          icon: const Icon(Icons.comment), // Replace with the desired icon
          label: const Text('Add Comment'),
        ),
      ),
    );
  }
}
