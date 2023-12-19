import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReadingList extends StatefulWidget {
  final int id;

  const ReadingList({Key? key, required this.id}) : super(key: key);

  @override
  _ReadingListState createState() => _ReadingListState();
}

class _ReadingListState extends State<ReadingList> {
  bool isAdded = false;

  void _toggleLike() {
    setState(() {
      isAdded = !isAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () async {
            final response = await http.post(
              Uri.parse(
                  'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/readinglist-flutter/${widget.id}/'),
            );
            if (response.statusCode == 200) {
              _toggleLike();
              return json.decode(response.body);
            } else {
              throw Exception(
                  'Failed to like book. Status code: ${response.statusCode}');
            }
          },
          icon: Icon(
            isAdded ? Icons.bookmark : Icons.bookmark_border,
            color: isAdded ? Colors.blue : Colors.black,
          ), // Replace with the desired icon
          label: const Text('Add to reading list'),
        ),
      ),
    );
  }
}
