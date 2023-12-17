import 'package:flutter/material.dart';
import 'package:tugas_uas/model/reading_forum.dart';
import 'package:tugas_uas/readingforum_form.dart';
import 'package:tugas_uas/screen/readingforum_detail.dart';

class ReadingForumPage extends StatelessWidget {
  final Discussion? discussion;

  const ReadingForumPage({super.key, this.discussion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion Detail'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // Baris untuk navigasi ke ReadingForumFormPage
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke ReadingForumFormPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReadingForumFormPage(),
                  ),
                );
              },
              child: const Text('Create Discussion'),
            ),
          ),
          // Baris untuk navigasi ke ReadingForumDetailPage (berdasarkan diskusi yang diklik)
          if (discussion != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke ReadingForumDetailPage sesuai dengan diskusi yang diklik
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReadingForumDetailPage(discussion: discussion!),
                    ),
                  );
                },
                child: const Text('View Discussion Detail'),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildDetailRow(BuildContext context, String label, String value) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman ReadingForumDetailPage sesuai dengan diskusi yang diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (discussion != null) {
                return ReadingForumDetailPage(discussion: discussion!);
              } else {
                return Container();
              }
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '$label:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(value),
            ),
          ],
        ),
      ),
    );
  }
}
