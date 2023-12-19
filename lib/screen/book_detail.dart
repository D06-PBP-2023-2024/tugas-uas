import "dart:convert";

import "package:flutter/material.dart";
import "package:pbp_django_auth/pbp_django_auth.dart";
import "package:tugas_uas/model/book_detail.dart";
import "package:tugas_uas/screen/tag_form.dart";
import "package:tugas_uas/utils/titlecase.dart";
import "package:tugas_uas/widget/drawer.dart";
import "package:tugas_uas/widget/like.dart";
import "package:tugas_uas/widget/comment.dart";
import "package:tugas_uas/widget/reading-list.dart";
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
    final request = context.watch<CookieRequest>();
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
                  snapshot.data!.tags!.sort((self, other) =>
                      self.subject!.length - other.subject!.length);
                  return Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            snapshot.data!.coverUrl!,
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
                            snapshot.data!.title!.toTitleCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: snapshot.data!.tags!.map((tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tag.subject!.toTitleCase(),
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        (request.loggedIn
                            ? Container(
                                margin: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TagFormPage(id: id),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 29, 146, 43),
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      "Tambahkan Tag",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            : const Text("Log in untuk menambahkan tag")),
                        const Padding(
                            padding: EdgeInsets.all(8.0), child: LikeWidget()),
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CommentButton()),
                        const Padding(
                            padding: EdgeInsets.all(8.0), child: ReadingList()),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LikeWidget(id: id)),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommentButton(id: id)),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReadingList(id: id)),
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
