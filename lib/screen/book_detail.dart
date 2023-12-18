import "dart:convert";

import "package:flutter/material.dart";
import "package:tugas_uas/model/book_detail.dart";
import "package:tugas_uas/utils/titlecase.dart";
import "package:tugas_uas/widget/drawer.dart";
import 'package:http/http.dart' as http;

class BookDetail extends StatelessWidget {
  const BookDetail({super.key, required this.id});
  final int id;

  Future<Book> getBook() async {
    var url = "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/api/books/$id";
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return Book.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: const SideDrawer(),
      body: FutureBuilder(
        future: getBook(),
        builder: (context, AsyncSnapshot<Book> snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            snapshot.data!.fields!.coverUrl!,
                            width: 200,
                            height: 200,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.favorite),
                            Text(
                              snapshot.data!.likes!.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.comment),
                            Text(
                              snapshot.data!.comments!.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              snapshot.data!.downloadCount.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data!.fields!.title!.toTitleCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
