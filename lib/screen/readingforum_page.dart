import 'package:flutter/material.dart';
import 'package:tugas_uas/model/reading_forum.dart';
import 'package:tugas_uas/readingforum_form.dart';
import 'package:tugas_uas/screen/readingforum_detail.dart';
import 'package:tugas_uas/widget/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReadingForumPage extends StatefulWidget {
  @override
  _ReadingForumPageState createState() => _ReadingForumPageState();
}

class _ReadingForumPageState extends State<ReadingForumPage> {
  late List<Discussion> discussions;

  @override
  void initState() {
    super.initState();
    discussions = []; // Inisialisasi discussions dengan list kosong
    fetchDiscussions();
  }

  Future<void> fetchDiscussions() async {
    var url = Uri.parse('http://127.0.0.1:8000/reading_forum/discussion_list_json/');

    try {
      // Lakukan permintaan HTTP untuk mendapatkan daftar diskusi
      final response = await http.get(url);

      // Periksa apakah permintaan berhasil (status code 200)
      if (response.statusCode == 200) {
        // Parse respons JSON dan kembalikan daftar diskusi
        var data = json.decode(utf8.decode(response.bodyBytes));

        List<Discussion> list_discussion = [];
        for (var d in data['discussions']) {
          if (d != null) {
            list_discussion.add(Discussion.fromJson(d));
          }
        }

        setState(() {
          discussions = list_discussion;
        });
      } else {
        // Jika server tidak mengembalikan respons 200 OK,
        // lempar exception.
        throw Exception('Gagal mengambil daftar diskusi');
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi selama permintaan HTTP.
      print('Error fetching discussions: $e');
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
            // Button to navigate to ReadingForumFormPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReadingForumFormPage(),
                  ),
                );
              },
              child: const Text('Create Discussion'),
            ),
<<<<<<< HEAD
            const SizedBox(height: 16),
            if (discussions.isEmpty)
              Text('No discussions yet.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: discussions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(discussions[index].title),
                      subtitle: Text('User: ${discussions[index].user}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadingForumDetailPage(
                              discussion: discussions[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
=======
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
>>>>>>> dev
          ],
        ),
      ),
    );
  }
}
