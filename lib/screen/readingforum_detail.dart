import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_uas/model/reading_forum.dart';
import 'package:tugas_uas/model/reading_forum_detail.dart';
import 'package:tugas_uas/readingforum_replyform.dart';
import 'package:tugas_uas/readingforum_replyform.dart';
import 'package:tugas_uas/widget/drawer.dart';

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
        'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/reading_forum/discussion_detail_json/${widget.discussion.id}');

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
        title: const Text('Discussion Detail'),
      ),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            // if (replies.isEmpty)
            //   const Center(child: CircularProgressIndicator())
            // else
            Expanded(
              child: ListView.builder(
                itemCount: replies.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(replies[index].content),
                      subtitle: Text('By: ${replies[index].user}'),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReplyForm(id: widget.discussion.id),
                    ),
                  );
                },
                child: const Text('Reply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
