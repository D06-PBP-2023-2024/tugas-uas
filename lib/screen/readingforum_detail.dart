import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_uas/model/reading_forum.dart';
import 'package:tugas_uas/model/reading_forum_detail.dart';
import 'package:tugas_uas/readingforum_replyform.dart';
import 'package:tugas_uas/readingforum_replyform.dart';

class ReadingForumDetailPage extends StatefulWidget {
  final Discussion discussion;

  ReadingForumDetailPage({required this.discussion});

  @override
  _ReadingForumDetailPageState createState() => _ReadingForumDetailPageState();
}

class _ReadingForumDetailPageState extends State<ReadingForumDetailPage> {
  late List<Reply> replies = [];

  @override
  void initState() {
    super.initState();
    fetchReplies();
  }

  Future<void> fetchReplies() async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/reading_forum/discussion_detail_json/${widget.discussion.id}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));

        List<Reply> list_replies = [];
        for (var d in data['replies']) {
          if (d != null) {
            list_replies.add(Reply.fromJson(d));
          }
        }

        setState(() {
          replies = list_replies;
        });
      } else {
        throw Exception('Failed to fetch replies');
      }
    } catch (e) {
      print('Error fetching replies: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Title: ${widget.discussion.title}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Content: ${widget.discussion.content}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('By: ${widget.discussion.user}'),
            ),
            if (replies == null)
              const Center(child: CircularProgressIndicator())
            else
              for (var reply in replies)
                Card(
                  child: ListTile(
                    title: Text(reply.content),
                    subtitle: Text('By: ${reply.user}'),
                  ),
                ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReplyForm(),
                    ),
                  );
                },
                child: Text('Reply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
