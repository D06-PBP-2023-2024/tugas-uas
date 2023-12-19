import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  final Key? key;
  @override
  _CommentPageState createState() => _CommentPageState();

  const CommentPage({this.key}) : super(key: key);
}

class _CommentPageState extends State<CommentPage> {
  List<String> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitur Komentar'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommentInput(onSubmit: addComment),
          ),
        ],
      ),
    );
  }

  void addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
  }
}

class CommentInput extends StatefulWidget {
  final Function(String) onSubmit;
  final Key? key;

  const CommentInput({required this.onSubmit, this.key}) : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: 'Tambahkan komentar...',
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            if (commentController.text.isNotEmpty) {
              widget.onSubmit(commentController.text);
              commentController.clear();
            }
          },
        ),
      ],
    );
  }
}
