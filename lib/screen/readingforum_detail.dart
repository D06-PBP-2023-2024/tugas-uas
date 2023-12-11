import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/model/reading_forum.dart';

class ReadingForumDetailPage extends StatelessWidget {
  final Discussion discussion;

  const ReadingForumDetailPage({required this.discussion});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        home: Scaffold(
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
        ),
      ),
    );
  }
}
