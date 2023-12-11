import 'package:flutter/material.dart';
import 'package:tugas_uas/model/reading_forum.dart';


class ReadingForumDetailPage extends StatelessWidget {
  final Discussion discussion;

  ReadingForumDetailPage({required this.discussion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Title: ${discussion.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Content: ${discussion.content}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('By: ${discussion.user}'),
          ),
        ],
      ),
    );
  }
}
