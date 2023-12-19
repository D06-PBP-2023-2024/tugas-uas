import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LikeWidget extends StatefulWidget {
  final int id;
  const LikeWidget({Key? key, required this.id}) : super(key: key);

  @override
  _LikeWidgetState createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
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
                  'https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/like-flutter/${widget.id}/'),
              headers: {
                'Content-Type': 'application/json',
              },
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
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.black,
          ), // Replace with the desired icon
          label: const Text('Tap to like'),
        ),
      ),
    );
  }
}
