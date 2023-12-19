import "package:flutter/material.dart";
import "package:pbp_django_auth/pbp_django_auth.dart";
import "package:tugas_uas/model/book_detail.dart";
import "package:tugas_uas/screen/comment_form.dart";
import "package:tugas_uas/screen/login.dart";
import "package:tugas_uas/screen/tag_form.dart";
import "package:tugas_uas/utils/titlecase.dart";
import "package:tugas_uas/widget/drawer.dart";
import 'package:provider/provider.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({super.key, required this.id});
  final int id;

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  bool liked = false;
  bool added = false;
  int likesCount = 0;
  int commentCount = 0;
  Future<Book> getBook(CookieRequest req) async {
    var url =
        "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/api/books/${widget.id}";
    final response = await req.get(url);
    var j = Book.fromJson(response);
    return j;
  }

  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    if (request.loggedIn) {
      getBook(request).then((value) {
        setState(() {
          liked = value.liked!;
          likesCount = value.likes!.length;
          commentCount = value.comments!.length;
          added = value.added!;
        });
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
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
        future: getBook(request),
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
                            IconButton(
                              onPressed: () async {
                                var url =
                                    "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/like/${widget.id}/";
                                final response = await request.get(url);
                                setState(() {
                                  liked = response["liked"];
                                  likesCount = response["likes_count"];
                                });
                              },
                              icon: Icon(
                                liked ? Icons.favorite : Icons.favorite_border,
                                color: liked ? Colors.red : Colors.black,
                              ),
                            ),
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
                            IconButton(
                                onPressed: () async {
                                  var url =
                                      "https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/add-reading-list-flutter/${widget.id}/";
                                  final response = await request.get(url);
                                  setState(() {
                                    added = response["added"];
                                  });
                                },
                                icon: Icon(added
                                    ? Icons.bookmark
                                    : Icons.bookmark_add_outlined),
                                color: added ? Colors.blue : Colors.grey),
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
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TagFormPage(id: widget.id),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 29, 146, 43),
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (commentCount > 0
                            ? Column(
                                children:
                                    snapshot.data!.comments!.map((comment) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(comment.comment!),
                                      subtitle: Text(comment.user!),
                                    ),
                                  );
                                }).toList(),
                              )
                            : const Text("Tidak ada komentar")),
                        // Comment Form
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CommentForm(id: widget.id),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 29, 146, 43),
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Tambahkan Komentar",
                                style: TextStyle(color: Colors.white),
                              )),
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
